defmodule Demo.GabAccounts do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.GabAccounts.GabAccount
  alias Demo.ABC
  alias Demo.ABC.OpenT1
  alias Demo.ABC.OpenT2
  alias Demo.ABC.OpenT3
  alias Demo.ABC.OpenT4
  # alias Demo.T3s
  alias Demo.T3s.T3
  alias Demo.Entities.Entity
  alias Demo.Gabs.Gab

  # def init_gab_account(gab_account, attrs) do
  #   t2 = %T2{}
  #   t4 = %T4{}

  #   gab_account
  #   |> GabAccount.changeset_gab()

  # end

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

    decimal_0 = Decimal.sub(t1_change, t1_change)

    cond do
      t2_change > decimal_0 ->
        t1_to_t2(gab_account, t2_change)

      t2_change < decimal_0 ->
        t2_to_t1(gab_account, t2_change)

      t2_change == decimal_0 ->
        true
    end

    t3_0 = Decimal.from_float(0.0000)

    cond do
      t3_change > decimal_0 ->
        t1_to_t3(gab_account, t3_change)

      t3_change < decimal_0 ->
        t3_to_t1(gab_account, t3_change)

      t3_change == decimal_0 ->
        true
    end

    t4_0 = Decimal.from_float(0.0000)

    cond do
      t4_change > decimal_0 ->
        t1_to_t4(gab_account, t4_change)

      t4_change < decimal_0 ->
        IO.puts "I am here, t4_change < decimal_0"
        t4_to_t1(gab_account, t4_change)

      t4_change == decimal_0 ->
        true
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

  def process_transfer(event, input, output, openhash) do
    input_GA = Repo.preload(input, :gab_account).gab_account
    new_t1_balance = Decimal.sub(input_GA.t1_balance, event.input_amount)
    # update_gab_account(input_GA, %{t1_balance: new_t1_balance})
    attrs = %{t1_balance: new_t1_balance}

    input_GA
    |> GabAccount.changeset(attrs)
    |> Repo.update()

    renew_t1s(event, input, output, openhash)
  end

  def renew_t1s(attrs, input, output, openhash) do
    # ? Find input's GA
    query =
      from g in GabAccount,
        where: g.entity_id == ^input.id

    input_GA = Repo.one(query)

    # ? renew Buyer's GA T1
    open_t1s = [
      %OpenT1{
        openhash_id: openhash.id,
        input_id: input.id,
        input_name: input.name,
        output_id: input.id,
        output_name: input.name,
        output_amount: input_GA.t1_balance
      }
    ]

    input_GA
    |> GabAccount.changeset()
    |> Ecto.Changeset.put_embed(:open_t1s, open_t1s)
    |> Repo.update!()
    |> update_t1_balance()

    # ? renew Seller's GA
    # ? prepare open_t struct to pay.

    # ? First, find out whether the currency of input and that of output equal or not
    # ? If different, foreign exchange input to output.
    input_currency = input.default_currency
    output_currency = output.default_currency

    output_amount =
      case input_currency == output_currency do
        true -> attrs.input_amount
        false -> fx(input_currency, output_currency, attrs.input_amount)
      end

    open_t1 = %OpenT1{
      openhash_id: openhash.id,
      input_name: input.name,
      input_id: input.id,
      output_name: output.name,
      output_id: output.id,
      output_amount: output_amount
    }

    # ? Find output's GA
    query =
      from g in GabAccount,
        where: g.entity_id == ^output.id

    output_GA = Repo.one(query)

    add_open_t1s(output_GA, %{open_t1: open_t1})
  end

  defp fx(input_currency, output_currency, amount) do
    # ? return dummy data
    amount
  end

  def add_open_t1s(%GabAccount{} = gab_account, attrs) do
    # ? update gab account and t1_balance.
    open_t1s = [attrs.open_t1 | gab_account.open_t1s]

    gab_account
    |> GabAccount.changeset_open(%{open_t1s: open_t1s})
    |> Repo.update!()
    |> update_t1_balance()
  end

  def sub_open_t1s(%GabAccount{} = gab_account, attrs) do
    # ? update gab account and t1_balance.
    # open_t1s = [open_t1]]

    # gab_account
    # |> GabAccount.changeset_open(%{open_t1s: open_t1s})
    # |> Repo.update!()
    # |> update_t1_balance()
  end

  # ? When new fiat amounts come to GABs from outside world.
  def new_deposit(open_t1) do
    
    gab = Repo.one(from g in Gab, where: g.id == ^open_t1.input_id, select: g)
    output = Repo.one(from e in Entity, where: e.id == ^open_t1.output_id, select: e)
    
    input_currency = open_t1.input_currency
    output_currency = output.default_currency
    input_amount = open_t1.input_amount
    
    output_amount =
    case input_currency == output_currency do
      true -> input_amount
      false -> fx(input_currency, output_currency, input_amount)
    end
    
    open_t1 = Map.merge(open_t1, %{output_currency: output_currency, output_amount: output_amount})
    
    # ? update gab_account of output.
    gab_account = Repo.preload(output, :gab_account).gab_account
    add_open_t1s(gab_account, %{open_t1: open_t1})
    
    # ? Update t1_pool of the gab
    input_currency = String.to_atom(open_t1.input_currency)
    t1_pool = Repo.preload(gab, :t1_pool).t1_pool
    t1_pool = Map.update!(t1_pool, input_currency, &Decimal.add(&1, output_amount))
  end

  def update_t1_balance(gab_account) do
    amount_list = Enum.map(gab_account.open_t1s, fn open_t1 -> open_t1.output_amount end)
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

    added_t1 = %OpenT1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: amount,
      input_currency: t1_currency
    }

    update_gab_account(gab_account, %{open_t1: added_t1, t1_balance: new_t1_balance})
  end

  '''

    Below are for openhash archive

  '''

  def withdraw_t1(gab_account, t1_currency, amount) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab
    entity = Repo.preload(gab_account, :entity).entity

    new_t1_balance = Decimal.sub(gab_account.t1_balance, amount)

    open_t1 = %OpenT1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: amount,
      input_currency: t1_currency
    }

    new_open_t1s = [open_t1]
    update_gab_account(gab_account, %{open_t1s: new_open_t1s, t1_balance: new_t1_balance})
  end

  # ? exchange a fiat currency with FX-risk free currency.
  # ? default is all
  def t1_to_t2(gab_account, amount_to_exchange) do
    t1_currency = gab_account.default_currency
    gab = Repo.preload(gab_account, :gab).gab

    entity = Repo.preload(gab_account, :entity).entity

    # ? Record T2 transaction
    open_t2 = %OpenT2{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: amount_to_exchange
    }

    new_open_t2s = [open_t2 | gab_account.open_t2s]

    # ? T1
    new_t1_amount = Decimal.sub(gab_account.t1_balance, amount_to_exchange)

    open_t1 = %OpenT1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: new_t1_amount,
      input_currency: t1_currency
    }

    new_open_t1s = [open_t1]

    openhash_t1_to_t2(gab_account, %{
      open_t1s: new_open_t1s,
      open_t2s: new_open_t2s
    })

    # ? Update T2 acccount
    bought_t2 = ABC.buy_t2(t1_currency, amount_to_exchange)

    prev_t2 = Repo.preload(gab_account, :t2).t2
    new_t2 = Map.merge(prev_t2, bought_t2, fn _key, a, b -> Decimal.add(a, b) end)

    update_t2(gab_account, new_t2)
  end

  defp update_t2(gab_account, new_t2) do
    gab_account = Repo.preload(gab_account, :t2)

    gab_account
    |> GabAccount.changeset_update_t2(%{t2: new_t2})
    |> Repo.update()
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

    open_t1 = %OpenT1{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: sold_t2_amount,
      input_currency: t1_currency
    }

    # ? add new_t1 to the t1 list of the seller.
    new_open_t1s = [open_t1 | gab_account.open_t1s]

    openhash_tx_to_t1(gab_account, %{
      open_t1s: new_open_t1s
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

    open_t1 = %OpenT1{
      input_name: entity.name,
      input_id: entity.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: new_t1_amount,
      input_currency: t1_currency
    }

    new_open_t1s = [open_t1]

    # ? amount of ABC shares
    open_t3 = %OpenT3{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: amount_to_buy,
      currency: t1_currency
    }

    new_open_t3s = [open_t3 | gab_account.open_t3s]

    openhash_t1_to_t3(gab_account, %{
      open_t1s: new_open_t1s,
      open_t3s: new_open_t3s
    })

    # ? Update T3 acccount
    bought_t3 = ABC.buy_t3(gab_account.default_currency, amount_to_buy)

    new_t3 = %T3{
      abc: bought_t3
    }

    gab_account = Repo.preload(gab_account, :t3)

    gab_account
    |> GabAccount.changeset_update_t3(%{t3: new_t3})
    |> Repo.update()
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
    sold_t3_amount = ABC.sell_t3(gab_account, t1_currency)

    # ? add the total t3_in_t1 revenue to gab_account
    open_t1 = %OpenT1{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: sold_t3_amount,
      input_currency: t1_currency
    }

    new_open_t1s = [open_t1 | gab_account.open_t1s]

    openhash_tx_to_t1(gab_account, %{
      open_t1s: new_open_t1s
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

    open_t4 = %OpenT4{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      amount: amount_to_exchange,
      currency: t1_currency
    }

    # ? add the bought T4 to the existing T4 of the gab_account.
    new_open_t4s = [open_t4 | gab_account.open_t4s]

    # ? adjust t1s
    new_t1_amount = Decimal.sub(gab_account.t1_balance, amount_to_exchange)

    open_t1 = %OpenT1{
      input_name: entity.name,
      output_name: entity.name,
      input_name: entity.name,
      output_name: entity.name,
      input_amount: new_t1_amount,
      input_currency: t1_currency
    }

    new_open_t1s = [open_t1]

    openhash_t1_to_t4(gab_account, %{
      open_t1s: new_open_t1s,
      open_t4s: new_open_t4s
    })

    # ? Update T2 acccount
    bought_t4 = ABC.buy_t4(t1_currency, amount_to_exchange)
    gab_account = Repo.preload(gab_account, :t4)
    new_t4 = Map.merge(gab_account.t4, bought_t4, fn _key, a, b -> Decimal.add(a, b) end)

    update_t4(gab_account, new_t4)
  end

  defp update_t4(gab_account, new_t4) do
    gab_account = Repo.preload(gab_account, :t4)
    gab_account
    |> GabAccount.changeset_update_t4(%{t4: new_t4})
    |> Repo.update()
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

    open_t1 = %OpenT1{
      input_name: gab.name,
      input_id: gab.id,
      output_name: entity.name,
      output_id: entity.id,
      input_amount: sold_t4_amount,
      input_currency: t1_currency
    }

    new_open_t1s = [open_t1 | gab_account.open_t1s]

    openhash_tx_to_t1(gab_account, %{
      open_t1s: new_open_t1s
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
