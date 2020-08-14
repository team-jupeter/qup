defmodule Demo.ABC do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T2s.T2
  alias Demo.T4s.T4
  alias Demo.GabAccounts


  def exchange_t1(gab_account, from_fiat, to_fiat) do    
    fx_rate = GabAccounts.get_fx_rate(from_fiat, to_fiat)
    Decimal.mult(fx_rate, gab_account.t1_balance)

  end

  def buy_t2(t1_currency, amount_to_exchange) do
    # ? There are 15 T2 items, and we need to buy each item equally. 
    # ? Amount to buy for each T2 item in t2 list. 
    each_t2_amount = Decimal.div(amount_to_exchange, 15)

    # ? find fx rate of each fiat in t2 fiat list.
    t2_struct = %{
      usd: 0.0, eur: 0.0, jpy: 0.0, gbp: 0.0, aud: 0.0, cad: 0.0, 
      chf: 0.0, cny: 0.0, sek: 0.0, mxn: 0.0, nzd: 0.0, sgd: 0.0, 
      hkd: 0.0, nok: 0.0, krw: 0.0
    }

    fx_rates =
      for {k, v} <- t2_struct,
          into: %{},
          do: {k, get_fx_rate(k, t1_currency)}
    

    bought_t2 =
      for {k, v} <- fx_rates,
          into: %{},
          do: {k, Decimal.mult(v, each_t2_amount)}
  end

  def sell_t2(gab_account) do
    t1_currency = gab_account.default_currency

    # ? find fx rate of each fiat in t2 fiat list.
    t2_struct = %T2{
      usd: 0.0, eur: 0.0, jpy: 0.0, gbp: 0.0, aud: 0.0, cad: 0.0, 
      chf: 0.0, cny: 0.0, sek: 0.0, mxn: 0.0, nzd: 0.0, sgd: 0.0, 
      hkd: 0.0, nok: 0.0, krw: 0.0
    }
    fx_rates = for {k, v} <- t2_struct, into: %{}, do: {k, get_fx_rate(k, t1_currency)}

    # ? calculate price of each fiat in T2.
    t1_price_of_t2 = Map.merge(fx_rates, gab_account.t2, fn _key, a, b -> Decimal.mult(a, b) end)
    all_t2_in_t1 = Enum.reduce(t1_price_of_t2, 0, fn {_k, v}, acc -> Decimal.add(v, acc) end)
  end

  defp get_fx_rate(fiat_to_sell, fiat_to_buy) do
    # ? return dummy value
    1
  end

  def buy_t3(t1_currency, amount_to_exchange) do
    t3_price = get_t3_price(t1_currency)
    bought_t3 = Decimal.div(amount_to_exchange, t3_price)
  end

  def sell_t3(gab_account, t1_currency) do
    t3_price = get_t3_price(t1_currency)
    sold_t3 = Decimal.mult(gab_account.t3_balance, t3_price)
  end

  defp get_t3_price(_t1_currency) do
    # ? return dummy value
    1
  end


  def buy_t4(t1_currency, amount_to_buy) do
    index_list = %{
      nyse: 0.0, nasdaq: 0.0, jpx: 0.0, lse: 0.0, sse: 0.0, sehk: 0.0, ens: 0.0, 
      szse: 0.0, tsx: 0.0, bse: 0.0, nse: 0.0, db: 0.0, six: 0.0, krx: 0.0
    }

    buying_amount = Decimal.div(amount_to_buy, 14) |> Decimal.round(4)

    for {key, _value} <- index_list,
        into: %{},
        do: {key, fx(:buy, key, t1_currency, buying_amount)}
  end

  def sell_t4(t1_currency, gab_account) do
    # t1_revenue_list = Enum.map(gab_account.t4, fn {key, value} -> fx(:sell, key, value, default_currency) end)
    t4_in_t1 =
      for {key, value} <- gab_account.t4,
          into: %{},
          do: {key, fx(:sell, key, value, t1_currency)}

    # Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
    Enum.reduce(t4_in_t1, 0, fn {_key, value}, acc -> Decimal.add(value, acc) end)
  end

  defp fx(:buy, _key, _t1_currency, buying_amount) do
    # ? buy index of each exchange as much as buying amount at the exchange
    # ? dummy value
    buying_amount
  end

  defp fx(:sell, key, value, t1_currency) do
    # ? get the price of each index in t4 list, denoted by default_currency.
    index_price = get_index_price(key, t1_currency)
    Decimal.mult(index_price, value) |> Decimal.round(4)
  end

  defp get_index_price(_index, _t1_currency) do
    # ? dummy data
    1
  end
end
