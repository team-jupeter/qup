defmodule Demo.GabAccounts do
  @moduledoc """
  The GabAccounts context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo
  # import Ecto.Changeset

  alias Demo.GabAccounts.GabAccount
  alias Demo.ABC
  alias Demo.ABC.T1
  # alias Demo.ABC.T2
  # alias Demo.ABC.T4

  alias Demo.T3s

  alias Demo.Entities.Entity

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

  def renew_t1s(attrs, buyer, seller, openhash) do
    # ? Find buyer's BS
    query =
      from g in GabAccount,
        where: g.entity_id == ^buyer.id

    buyer_GA = Repo.one(query)

    # ? renew Buyer's GA T1
    t1s = [
      %T1{
        openhash_id: openhash.id,
        input_id: buyer.id,
        input_name: buyer.name,
        output_id: buyer.id,
        output_name: buyer.name,
        amount: buyer_GA.t1_balance
      }
    ]

    buyer_GA
    |> GabAccount.changeset
    |> Ecto.Changeset.put_embed(:t1s, t1s)
    |> Repo.update!()
    |> update_t1_balance()

    # ? renew Seller's GA
    # ? prepare t struct to pay.
    t_payment = %{
      t1: %T1{
        openhash_id: openhash.id,
        input_name: buyer.name,
        input_id: buyer.id,
        output_name: seller.name,
        output_id: seller.id,
        amount: attrs.amount
      }
    }

    # ? Find seller's GA
    query =
      from g in GabAccount,
        where: g.entity_id == ^seller.id

    seller_GA = Repo.one(query)

    add_t1s(seller_GA, t_payment)
  end

  def add_t1s(%GabAccount{} = gab_account, attrs) do
    t1s = [attrs.t1 | gab_account.t1s]
    gab_account
    |> GabAccount.changeset
    |> Ecto.Changeset.put_embed(:t1s, t1s)
    |> Repo.update!()
    |> update_t1_balance()
  end


  # alias Demo.Entities
  # alias Demo.GabAccounts

  def update_t1_balance(gab_account) do
    amount_list = Enum.map(gab_account.t1s, fn item -> item.amount end)
    t1_balance = Enum.reduce(amount_list, 0, fn amount, sum -> Decimal.add(amount, sum) end)
    update_gab_account(gab_account, %{t1_balance: t1_balance})

    # entity = Demo.Repo.preload(ga, :entity).entity
    # Entities.update_entity(entity, %{t1_balance: t1_balance})

    # gab_account = Repo.preload(entity, :gab_account).gab_account

    # IO.inspect " GabAccounts.update_gab_account"
    # IO.inspect t1_balance
    
    # GabAccounts.update_gab_account(gab_account, %{t1_balance: t1_balance})
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
      currency_type: t1_currency
    }

   update_gab_account(gab_account, %{t1: added_t1, t1_balance: new_t1_balance})
  end

  # ? Send T1 to another entity
  def send_t1(sender, receiver_email, t1_currency, amount) do
    sender_gab_account = Repo.preload(sender, :gab_account).gab_account

    receiver = Repo.one(from e in Entity, where: e.email == ^receiver_email, select: e)
    receiver_gab_account = Repo.preload(receiver, :gab_account).gab_account

    sender_new_t1_balance = Decimal.sub(sender_gab_account.t1_balance, amount)
    receiver_new_t1_balance = Decimal.add(receiver_gab_account.t1_balance, amount)

    receiver_added_t1 = %T1{
      input_name: sender.name,
      input_id: sender.id,
      output_name: receiver.name,
      output_id: receiver.id,
      amount: amount,
      currency_type: t1_currency
    }

    sender_t1 = %T1{
      input_name: sender.name,
      input_id: sender.id,
      output_name: sender.name,
      output_id: sender.id,
      amount: sender_new_t1_balance,
      currency_type: t1_currency
    }

   update_gab_account(sender_gab_account, %{
      t1: sender_t1,
      t1_balance: sender_new_t1_balance
    })

   update_gab_account(receiver_gab_account, %{
      t1: receiver_added_t1,
      t1_balance: receiver_new_t1_balance
    })
  end

  def withdraw_t1(entity, t1_currency, amount) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    new_t1_balance = Decimal.sub(gab_account.t1_balance, amount)

    new_t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: amount,
      currency_type: t1_currency
    }

   update_gab_account(gab_account, %{t1: new_t1, t1_balance: new_t1_balance})
  end

  # ? exchange one fiat currency with another.
  def t1_to_t1(entity, from_fiat, to_fiat) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    new_t1_balance = ABC.exchange_t1(entity, from_fiat, to_fiat)

    new_t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: new_t1_balance,
      currency_type: to_fiat
    }

   update_gab_account(gab_account, %{t1: new_t1, default_currency: to_fiat})
  end

  # ? exchange a fiat currency with FX-risk free currency.
  # ? default is all
  def t1_to_t2(entity, amount_to_exchange) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    t1_currency = gab_account.default_currency

    bought_t2 = ABC.buy_t2(gab_account, t1_currency, amount_to_exchange)
    new_t2 = Map.merge(gab_account.t2, bought_t2, fn _key, a, b -> Decimal.add(a, b) end)

    new_t1_amount = Decimal.sub(gab_account.t1, amount_to_exchange)

    new_t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: new_t1_amount,
      currency_type: gab_account.default_currency
    }

    # ? new T1, T2 balance
    new_t1_balance = Decimal.sub(gab_account.t1_balance, amount_to_exchange)
    new_t2_balance = Decimal.add(gab_account.t2_balance, amount_to_exchange)

   update_gab_account(gab_account, %{
      t1: new_t1,
      t2: new_t2,
      t1_balance: new_t1_balance,
      t2_balance: new_t2_balance
    })
  end

  # ? exchange FX-risk free currency with a fiat currency.
  # ? default is all
  def t2_to_t1(entity, amount_to_exchange) do
    gab_account = Repo.preload(entity, :gab_account).gab_account

    # ? Sell all T2
    all_t2_in_t1 = ABC.sell_t2(gab_account)

    # ? Re buy some T2, all_t2_in_t1 - amount_to_exchange
    amount_to_rebuy = Decimal.sub(all_t2_in_t1, amount_to_exchange)
    new_t2 = t1_to_t2(entity, amount_to_rebuy)

    # ? new T1, T2 balance
    new_t1_balance = Decimal.add(gab_account.t1_balance, amount_to_exchange)
    new_t2_balance = Decimal.sub(gab_account.t2_balance, amount_to_exchange)

    new_t1 = %T1{
      input_name: "GAB",
      output_name: entity.name,
      output_id: entity.id,
      amount: new_t1_balance,
      currency_type: gab_account.default_currency
    }

    # ? add new_t1 to the t1 list of seller.
    updated_t1 = [new_t1 | gab_account.t1]

   update_gab_account(gab_account, %{
      t1: updated_t1,
      t2: new_t2,
      t1_balance: new_t1_balance,
      t2_balance: new_t2_balance
    })
  end

  # ? quantity is the units of ABC.
  def t1_to_t3(entity, quantity_to_buy) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    t1_currency = gab_account.default_currency
    # ? number of ABCs to buy
    bought_t3 = T3s.buy_t3(gab_account, gab_account.default_currency, quantity_to_buy)

    # ? add new t3s to existing t3 list.
    new_t3 = Enum.concat(entity.t3, bought_t3)
    t3_price = T3s.get_t3_price(t1_currency)

    # ? renew t1 balance.
    new_t1_amount = Decimal.sub(gab_account.t1_balance, Decimal.mult(t3_price, quantity_to_buy))

    new_t1 = %T1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: new_t1_amount,
      currency_type: t1_currency
    }

    new_t1_balance = new_t1_amount
    new_t3_balance = Decimal.add(gab_account.t3_balance, Decimal.mult(t3_price, quantity_to_buy))

   update_gab_account(gab_account, %{
      t1: new_t1,
      t3: new_t3,
      t1_balance: new_t1_balance,
      t3_balance: new_t3_balance
    })
  end

  # ? quantity is the units of ABC.
  def t3_to_t1(entity, quantity_to_sell) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    t1_currency = gab_account.default_currency

    # ? sell all T3s of the gab_account
    t3_in_t1 = T3s.sell_t3(gab_account, t1_currency)

    # ? add the total t3_in_t1 revenue to gab_account
    newly_added_t1 = %T1{
      input_name: "GAB",
      output_name: entity.name,
      output_id: entity.id,
      amount: t3_in_t1,
      currency_type: gab_account.default_currency
    }

    new_t1 = [newly_added_t1 | gab_account.t1]

   update_gab_account(gab_account, %{t1: new_t1})

    # ? rebuy (gab_account.t3_balance - quantity_to_sell)
    t3_to_rebuy = gab_account.t3_balance - quantity_to_sell
    t1_to_t3(entity, t3_to_rebuy)
  end

  def t1_to_t4(entity, amount_to_exchange) do
    gab_account = Repo.preload(entity, :gab_account).gab_account
    t1_currency = gab_account.default_currency
    bought_t4 = ABC.buy_t4(t1_currency, amount_to_exchange)

    # ? add the bought T4 to the existing T4 of the gab_account.
    new_t4 = Map.merge(bought_t4, gab_account.t4, fn _key, a, b -> Decimal.add(a, b) end)
    new_t1_amount = Decimal.sub(gab_account.t1_balance, amount_to_exchange)

    new_t1 = %T1{
      input_name: entity.name,
      output_name: entity.name,
      amount: new_t1_amount,
      currency_type: t1_currency
    }

    new_t1_balance = Decimal.sub(gab_account.t1_balance, amount_to_exchange)
    new_t4_balance = Decimal.add(gab_account.t4_balance, amount_to_exchange)

   update_gab_account(gab_account, %{
      t1: new_t1,
      t4: new_t4,
      t1_balance: new_t1_balance,
      t4_balance: new_t4_balance
    })
  end

  def t4_to_t1(entity, amount_to_sell) do
    gab_account = Repo.preload(entity, :gab_account).gab_account

    # ? First, sell all T4 of the gab_account. 
    total_t1_revenue = ABC.sell_t4(gab_account.default_currency, amount_to_sell)

    new_t1 = %T1{
      input_name: "GAB",
      output_name: entity.name,
      amount: total_t1_revenue,
      currency_type: gab_account.default_currency
    }

    new_t1_balance = Decimal.add(gab_account.t1_balance, total_t1_revenue)

   update_gab_account(gab_account, %{
      t1: new_t1,
      t1_balance: new_t1_balance
    })

    # ? buy again T4 as much as (t4_balance - amount_to_sell)
    new_t4_balance = Decimal.sub(gab_account.t4_balance, amount_to_sell)
    t1_to_t4(entity, new_t4_balance)
  end

  def get_fx_rate(_fiat_a, _fiat_b) do
    # ? dummy data
    1
  end
end
