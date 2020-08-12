defmodule Demo.GabAccounts do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.GabAccounts.GabAccount
  alias Demo.ABC
  alias Demo.ABC.T1
  alias Demo.ABC.T2
  alias Demo.ABC.T3
  alias Demo.ABC.T4
  alias Demo.T3s
  alias Demo.Entities.Entity
  alias Demo.Gabs.Gab

  def list_gab_accounts do
    Repo.all(GabAccount)
  end

  def get_gab_account!(id), do: Repo.get!(GabAccount, id)

  def get_entity_gab_account!(entity_id) do
    GabAccount
    |> entity_gab_account_query(entity_id)
    |> Repo.one()
  end

  defp entity_gab_account_query(query, entity_id) do
    from(g in query, where: g.entity_id == ^entity_id)
  end

  def create_gab_account(attrs \\ %{}) do
    %GabAccount{}
    |> GabAccount.changeset(attrs)
    |> Repo.insert()
  end

  def update_gab_account(%GabAccount{} = gab_account, attrs) do
    attrs =
      case Map.has_key?(attrs, "t2_balance") do
        false ->
          t1_change = Decimal.sub(attrs.t1_balance, gab_account.t1_balance)

          # ? we need to add t1_change to total_book_value, as gab_account not yet reflect the updated t1 status.
          new_bv =
            Decimal.add(gab_account.t1_balance, gab_account.t2_balance)
            |> Decimal.add(gab_account.t3_balance)
            |> Decimal.add(gab_account.t4_balance)
            |> Decimal.add(t1_change)

          Map.merge(%{total_book_value: new_bv}, attrs)

        # ? this is the case when user manually adjust T1 ~ T5 shares.
        true ->
          previous_bv = gab_account.total_book_value

          new_bv =
            Decimal.add(attrs["t1_balance"], attrs["t2_balance"])
            |> Decimal.add(attrs["t3_balance"])
            |> Decimal.add(attrs["t4_balance"])

          attrs =
            case previous_bv == new_bv do
              true ->
                prev_t1_balance = gab_account.t1_balance
                prev_t2_balance = gab_account.t2_balance
                prev_t3_balance = gab_account.t3_balance
                prev_t4_balance = gab_account.t4_balance

                new_t1_balance = attrs["t1_balance"]
                new_t2_balance = attrs["t2_balance"]
                new_t3_balance = attrs["t3_balance"]
                new_t4_balance = attrs["t4_balance"]

                t1_change = Decimal.sub(new_t1_balance, prev_t1_balance)
                t2_change = Decimal.sub(new_t2_balance, prev_t2_balance)
                t3_change = Decimal.sub(new_t3_balance, prev_t3_balance)
                t4_change = Decimal.sub(new_t4_balance, prev_t4_balance)

                new_mv =
                  update_market_values(gab_account, t1_change, t2_change, t3_change, t4_change)

                Map.merge(new_mv, attrs)

              false ->
                "error"
            end
      end

    gab_account
    |> GabAccount.changeset(attrs)
    |> Repo.update()
  end

  defp update_market_values(gab_account, t1_change, t2_change, t3_change, t4_change) do
    # ? invest onto t2~t4, and record their openhashes.
    case t2_change >= 0 do
      true -> t1_to_t2(gab_account, t2_change)
      false -> t2_to_t1(gab_account, t2_change)
    end

    case t3_change >= 0 do
      true -> t1_to_t3(gab_account, t3_change)
      false -> t3_to_t1(gab_account, t3_change)
    end

    case t4_change >= 0 do
      true -> t1_to_t4(gab_account, t4_change)
      false -> t4_to_t1(gab_account, t4_change)
    end

    # ? update user screen
    new_t1_mv = Decimal.add(gab_account.t1_market_value, t1_change)
    new_t2_mv = Decimal.add(gab_account.t2_market_value, t2_change)
    new_t3_mv = Decimal.add(gab_account.t3_market_value, t3_change)
    new_t4_mv = Decimal.add(gab_account.t4_market_value, t4_change)

    total_market_value =
      Decimal.add(new_t1_mv, new_t2_mv)
      |> Decimal.add(new_t3_mv)
      |> Decimal.add(new_t4_mv)

    %{
      "total_market_value" => total_market_value,
      "t1_market_value" => new_t1_mv,
      "t2_market_value" => new_t2_mv,
      "t3_market_value" => new_t3_mv,
      "t4_market_value" => new_t4_mv
    }
  end

  def delete_gab_account(%GabAccount{} = gab_account) do
    Repo.delete(gab_account)
  end

  def change_gab_account(%GabAccount{} = gab_account) do
    GabAccount.changeset(gab_account, %{})
  end


  def process_transfer(event, erl, ssu, openhash) do
    erl_GA = Repo.preload(erl, :gab_account).gab_account
    new_t1_balance = Decimal.sub(erl_GA.t1_balance, event.t1_amount)
    # update_gab_account(erl_GA, %{t1_balance: new_t1_balance})
    attrs = %{t1_balance: new_t1_balance}

    erl_GA
    |> GabAccount.changeset(attrs)
    |> Repo.update()

    renew_t1s(event, erl, ssu, openhash)
  end

  def renew_t1s(attrs, erl, ssu, openhash) do
    # ? Find erl's GA
    query =
      from g in GabAccount,
        where: g.entity_id == ^erl.id

    erl_GA = Repo.one(query)

    # ? renew Buyer's GA T1
    t1s = [
      %T1{
        openhash_id: openhash.id,
        input_id: erl.id,
        input_name: erl.name,
        output_id: erl.id,
        output_name: erl.name,
        amount: erl_GA.t1_balance
      }
    ]

    erl_GA
    |> GabAccount.changeset()
    |> Ecto.Changeset.put_embed(:t1s, t1s)
    |> Repo.update!()
    |> update_t1_balance()

    # ? renew Seller's GA
    # ? prepare t struct to pay.
    attrs = %{
      t1: %T1{
        openhash_id: openhash.id,
        input_name: erl.name,
        input_id: erl.id,
        output_name: ssu.name,
        output_id: ssu.id,
        amount: attrs.t1_amount
      }
    }

    # ? Find ssu's GA
    query =
      from g in GabAccount,
        where: g.entity_id == ^ssu.id

    ssu_GA = Repo.one(query)

    add_t1s(ssu_GA, attrs)
  end

  def add_t1s(%GabAccount{} = gab_account, attrs) do
    # ? update gab account and t1_balance.
    t1s = [attrs.t1 | gab_account.t1s]

    gab_account
    |> GabAccount.changeset()
    |> Ecto.Changeset.put_embed(:t1s, t1s)
    |> Repo.update!()
    |> update_t1_balance()
  end

  # ? When new fiat amounts come to GABs from outside world.
  def new_deposit(t1) do
    currency = String.to_atom(t1.currency)

    gab = Repo.one(from g in Gab, where: g.id == ^t1.input_id, select: g)
    ssu = Repo.one(from e in Entity, where: e.id == ^t1.output_id, select: e)

    # ? Update t1_pool of the gab
    t1_pool = Repo.preload(gab, :t1_pool).t1_pool

    t1_pool = Map.update!(t1_pool, currency, &Decimal.add(&1, t1.amount))
    # T1Pools.update_t1_pool(t1_pool, t1_pool.krw)

    # ? update gab_account of ssu.
    gab_account = Repo.preload(ssu, :gab_account).gab_account
    add_t1s(gab_account, %{t1: t1})
  end

  # alias Demo.Entities
  # alias Demo.GabAccounts

  def update_t1_balance(gab_account) do
    amount_list = Enum.map(gab_account.t1s, fn item -> item.amount end)
    t1_balance = Enum.reduce(amount_list, 0, fn amount, sum -> Decimal.add(amount, sum) end)

    update_gab_account(gab_account, %{t1_balance: t1_balance})
  end

  def minus_t1_balance(%GabAccount{} = gab_account, %{amount: amount}) do
    new_balance = Decimal.sub(gab_account.t1_balance, amount)
    update_gab_account(gab_account, %{t1_balance: new_balance})
  end

  def plus_t1_balance(%GabAccount{} = gab_account, %{amount: amount}) do
    new_balance = Decimal.add(gab_account.t1_balance, amount)
    update_gab_account(gab_account, %{t1_balance: new_balance})
  end

  # ? deposit to GAB
  def deposit_t1(entity, t1_currency, amount) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    new_t1_balance = Decimal.add(gab_account.t1_balance, amount)

    added_t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: amount,
      currency: t1_currency
    }

    update_gab_account(gab_account, %{t1: added_t1, t1_balance: new_t1_balance})
  end

  '''

    Below are for openhash archive

  '''

  def withdraw_t1(gab_account, t1_currency, amount) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    new_t1_balance = Decimal.sub(gab_account.t1_balance, amount)

    t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: amount,
      currency: t1_currency
    }

    new_t1s = [t1]
    update_gab_account(gab_account, %{t1s: new_t1s, t1_balance: new_t1_balance})
  end

  # ? exchange a fiat currency with FX-risk free currency.
  # ? default is all
  def t1_to_t2(gab_account, amount_to_exchange) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    bought_t2_amount = ABC.buy_t2(gab_account, t1_currency, amount_to_exchange)
    # new_t2_amount = Map.merge(gab_account.t2, bought_t2, fn _key, a, b -> Decimal.add(a, b) end)

    t2 = %T2{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: bought_t2_amount,
      currency: t1_currency
    }

    t2 = %T2{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: bought_t2_amount
    }

    new_t2s = [t2 | gab_account.t2s]

    new_t1_amount = Decimal.sub(gab_account.t1, amount_to_exchange)

    t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: new_t1_amount,
      currency: t1_currency
    }

    new_t1s = [t1]

    openhash_t1_to_t2(gab_account, %{
      t1s: new_t1s,
      t2s: new_t2s
    })
  end

  defp openhash_t1_to_t2(gab_account, attrs) do
    gab_account
    |> GabAccount.changeset_t1_to_t2(attrs)
    |> Repo.update()
  end

  # ? exchange FX-risk free currency with a fiat currency.
  def t2_to_t1(gab_account, amount_to_exchange) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    # ? Sell all T2s of the gab_account
    sold_t2_amount = ABC.sell_t2(gab_account)

    t1 = %T1{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: sold_t2_amount,
      currency: t1_currency
    }

    # ? add new_t1 to the t1 list of the seller.
    new_t1s = [t1 | gab_account.t1s]

    openhash_tx_to_t1(gab_account, %{
      t1s: new_t1s
    })

    # ? Re buy some T2, sold_t2_amount - amount_to_exchange
    amount_to_rebuy = Decimal.sub(sold_t2_amount, amount_to_exchange)
    t1_to_t2(gab_account, amount_to_rebuy)
  end

  defp openhash_tx_to_t1(gab_account, attrs) do
    gab_account
    |> GabAccount.changeset_tx_to_t1(attrs)
    |> Repo.update()
  end

  # ? amount_to_buy is designated in T1
  def t1_to_t3(gab_account, amount_to_buy) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    # ? renew t1 balance.
    t3_price = get_t3_price(t1_currency)

    new_t1_amount = Decimal.sub(gab_account.t1_balance, Decimal.mult(t3_price, amount_to_buy))

    t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: new_t1_amount,
      currency: t1_currency
    }

    new_t1s = [t1]

    # ? amount of ABC shares
    bought_t3_amount = T3s.buy_t3(gab_account, gab_account.default_currency, amount_to_buy)

    t3 = %T3{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: bought_t3_amount
    }

    new_t3s = [t3 | gab_account.t3s]

    openhash_tx_to_t1(gab_account, %{
      t1s: new_t1s,
      t3s: new_t3s
    })
  end

  defp openhash_t1_to_t3(gab_account, attrs) do
    gab_account
    |> GabAccount.changeset_t1_to_t3(attrs)
    |> Repo.update()
  end

  defp get_t3_price(t1_currency) do
    30000
  end

  def t3_to_t1(gab_account, amount_to_sell) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    # ? sell all T3s of the gab_account
    sold_t3_amount = T3s.sell_t3(gab_account, t1_currency)

    # ? add the total t3_in_t1 revenue to gab_account
    t1 = %T1{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: sold_t3_amount,
      currency: t1_currency
    }

    new_t1s = [t1 | gab_account.t1s]

    openhash_tx_to_t1(gab_account, %{
      t1s: new_t1s
    })

    # ? rebuy (gab_account.t3_balance - amount_to_sell)
    t3_to_rebuy = gab_account.t3_balance - amount_to_sell
    t1_to_t3(gab_account, t3_to_rebuy)
  end

  def t1_to_t4(gab_account, amount_to_exchange) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    bought_t4_amount = ABC.buy_t4(t1_currency, amount_to_exchange)

    t4 = %T4{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: bought_t4_amount,
      currency: t1_currency
    }

    # ? add the bought T4 to the existing T4 of the gab_account.
    new_t4s = [t4 | gab_account.t4s]

    # ? adjust t1s
    new_t1_amount = Decimal.sub(gab_account.t1_balance, amount_to_exchange)

    t1 = %T1{
      input_name: entity.name,
      output_name: entity.name,
      input_name: entity.name,
      output_name: entity.name,
      amount: new_t1_amount,
      currency: t1_currency
    }

    new_t1s = [t1]

    openhash_t1_to_t4(gab_account, %{
      t1s: new_t1s,
      t4s: new_t4s
    })
  end

  defp openhash_t1_to_t4(gab_account, attrs) do
    gab_account
    |> GabAccount.changeset_t1_to_t4(attrs)
    |> Repo.update()
  end

  def t4_to_t1(gab_account, amount_to_sell) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    # ? First, sell all T4 of the gab_account. 
    sold_t4_amount = ABC.sell_t4(t1_currency, amount_to_sell)

    t1 = %T1{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: sold_t4_amount
    }

    new_t1s = [t1 | gab_account.t1s]

    openhash_tx_to_t1(gab_account, %{
      t1s: new_t1s
    })

    # ? buy again T4 as much as (t4_balance - amount_to_sell)
    new_t4_balance = Decimal.sub(gab_account.t4_balance, amount_to_sell)
    t1_to_t4(gab_account, new_t4_balance)
  end

  def get_fx_rate(_fiat_a, _fiat_b) do
    # ? dummy data
    1
  end
end
