defmodule Demo.T2s do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T2s.T2
  alias Demo.ABC.OpenT1

  def list_t2s do
    Repo.all(T2)
  end

  def get_t2!(id), do: Repo.get!(T2, id)

  def create_t2(attrs \\ %{}) do
    %T2{}
    |> T2.changeset(attrs)
    |> Repo.insert()
  end

  def update_t2(%T2{} = t2, attrs) do
    t2
    |> T2.changeset(attrs)
    |> Repo.update()
  end

  def delete_t2(%T2{} = t2) do
    Repo.delete(t2)
  end

  def change_t2(%T2{} = t2) do
    T2.changeset(t2, %{})
  end

  def buy_t2(gab_account, t1_currency, amount_to_exchange) do
    # ? There are 15 T2 items, and we need to buy each item equally. 
    # ? Amount to buy for each T2 item in t2 list. 
    each_t2_amount = Decimal.div(amount_to_exchange, 15)

    # ? find fx rate of each fiat in t2 fiat list.
    t2_struct = create_t2()

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
    t2_struct = create_t2()
    fx_rates = for {k, v} <- t2_struct, into: %{}, do: {k, get_fx_rate(k, t1_currency)}

    # ? calculate price of each fiat in T2.
    t1_price_of_t2 = Map.merge(fx_rates, gab_account.t2, fn _key, a, b -> Decimal.mult(a, b) end)
    all_t2_in_t1 = Enum.reduce(t1_price_of_t2, 0, fn {_k, v}, acc -> Decimal.add(v, acc) end)
  end

  defp get_fx_rate(fiat_to_sell, fiat_to_buy) do
    # ? return dummy value
    1
  end
end
