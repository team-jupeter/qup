defmodule Demo.GabAccounts do
  @moduledoc """
  The GabAccounts context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.GabAccounts.GabAccount

  def list_gab_accounts do
    Repo.all(GabAccount)
  end

  def get_gab_account!(id), do: Repo.get!(GabAccount, id)

  def get_entity_gab_account(entity_id) do
    GabAccount
    |> entity_gab_account_query(entity_id)
    |> Repo.one()
  end

  defp entity_gab_account_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end

  def create_gab_account(attrs \\ %{}) do
    %GabAccount{}
    |> GabAccount.changeset(attrs)
    |> Repo.insert()
  end

  def update_gab_account(%GabAccount{} = gab_account, attrs) do
    gab_account
    |> GabAccount.changeset(attrs)
    |> Repo.update()
  end

  def delete_gab_account(%GabAccount{} = gab_account) do
    Repo.delete(gab_account)
  end

  def change_gab_account(%GabAccount{} = gab_account) do
    GabAccount.changeset(gab_account, %{})
  end

  alias Demo.ABC.T1

  def renew_ts(attrs, buyer, seller) do
    # ? Find buyer's BS
    query =
      from g in GabAccount,
        where: g.entity_id == ^buyer.id

    buyer_GA = Repo.one(query)

    # ? renew Buyer's BS T1
    t_change = Decimal.sub(buyer_GA.t1, attrs.amount)

    IO.inspect "t_change"
    IO.inspect t_change

    attrs = %{
      gab_balance: t_change,
      ts: %T1{
        input_name: buyer.name,
        output_name: seller.name,
        amount: attrs.amount
      }
    }

    add_ts(buyer_GA, attrs)

    # ? Find seller's GA
    query =
      from b in GabAccount,
        where: b.entity_id == ^seller.id

    seller_GA = Repo.one(query)

    add_ts(seller_GA, attrs)
  end

  def add_ts(%GabAccount{} = gab_account, attrs) do
    ts = [attrs.ts | gab_account.ts]
    
    gab_account
    |> GabAccount.changeset()
    |> Ecto.Changeset.put_embed(:ts, ts)
    |> Repo.update!()
  end

  #? exchange one fiat currency with another.
  def t1_to_t1(entity, fiat_to_sell, fiat_to_buy, amount_to_exchange) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    new_t1_amount = T1Lists.exchange_t1(entity, fiat_to_sell, fiat_to_buy, amount_to_exchange)
    new_t1 = %T1{
      input: entity.name,
      output: entity.name,
      amount: new_t1_amount,
      currency: fiat_to_buy
    }

    GabAccounts.update(gab_account, %{t1: new_t1})
  end

  #? exchange a fiat currency with FX-risk free currency.
  def t1_to_t2(entity, fiat_to_sell, amount_to_exchange) do #? default is all
    gab_account = Repo.preload(entity, :gab_account).gab_account
    bought_t2 = T2Lists.buy_t2(fiat_to_sell, amount_to_exchange)
    new_t2 = Map.merge(gab_account.t2, bought_t2, fn key, a, b -> Decimal.add(a, b) end)
    new_t1_amount = Decimal.sub(gab_account.t1, amount_to_exchange)
    new_t1 = %T1{
      input: entity.name,
      output: entity.name,
      amount: new_t1_amount,
      currenty: fiat_to_sell
    }

    GabAccounts.update(entity, %{t2: new_t2, t1: new_t1})
  end

  #? exchange FX-risk free currency with a fiat currency.
  def t2_to_t1(entity, amount_to_sell) do #? default is all
    gab_account = Repo.preload(entity, :gab_account).gab_account
    new_t1_amount = T2Lists.sell_t2(gab_account, amount_to_sell)
    new_t1 = %T1{
      input: entity.name,
      output: entity.name,
      amount: new_t1_amount,
      currenty: gab_account.default_currency
    }
    updated_t1 = [new_t1 | gab_account.t1]

    GabAccounts.update(gab_account, %{t1: updated_t1})
  end

  def t1_to_t3(entity, quantity_to_buy) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    bought_t3 = T3s.buy_t3(gab_account, quantity_to_buy)
    t3_price_to_pay = T3s.get_t3_price()

    new_t3 = Enum.concat(entity.t3, bought_t3)
    new_t1_amount = Decimal.sub(gab_account.gab_balance, Decimal.mult(t3_price_to_pay, quantity_to_buy))
    new_t1 = %T1{
      input: entity.name,
      output: entity.name,
      amount: new_t1_amount,
      currenty: gab_account.default_currency
    }

    GabAccounts.update(gab_account, %{t1: new_t1, t3: new_t3})
  end

  def t3_to_t1(entity, quantity_to_sell) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    remained_t3 = T3s.sell_t3(gab_account, quantity_to_sell)
    t3_price = Gabs.get_t3_price()
    received_t1_amount = Decimal.mult(t3_price, quantity_to_sell)
    t1_to_add = %T1{
      input: gab.name,
      output: entity.name,
      amount: received_t1_amount,
      currenty: gab_account.default_currency
    }

    new_t1 = [t1_to_add | gab_account.t1]

    GabAccounts.update(gab_account, %{t1: new_t1, t3: remained_t3})
  end

  def t1_to_t4(entity, fiat_name, amount_to_buy) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    bought_t4 = T4Lists.buy_t4(gab_account, amount_to_buy)

    #? add the bought T4 to the existing T4 of the gab_account.
    new_t4 = Map.merge(bought_t4, gab_account.t4, fn key, a, b -> Decimal.add(a, b))
    new_t1_amount = Decimal.sub(gab_account.gab_balance, amount_to_buy)
    new_t1 = %T1{
      input: entity.name,
      output: entity.name,
      amount: new_t1_amount,
      currenty: gab_account.default_currency
    }

    GabAccounts.update_gab_account(gab_account, %{t1: new_t1, t4: new_t4})
  end

  def t4_to_t1(entity, amount_to_sell) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    total_t1_revenue = T4Lists.sell_t4(gab_account, amount_to_sell)
    new_t1 = %T1{
      input: gab.name,
      output: entity.name,
      amount: total_t1_revenue,
      currenty: gab_account.default_currency
    }

    GabAccounts.update_gab_account(gab_account, %{t1: new_t1, t4: new_t4})
    GabAccounts.update(gab_account, %{t1: new_t1, t4: new_})
    
    #? buy again T4 as much as (t4_balance - amount_to_sell)
    amount_to_buy = gab_account.t4_balance - amount_to_sell
    new_t4 = t1_to_t4(entity, fiat_name, amount_to_buy)
  end
end
