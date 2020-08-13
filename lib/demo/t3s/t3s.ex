defmodule Demo.T3s do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T3s.T3
  # alias Demo.T1s.T1

  def list_t3s do
    Repo.all(T3)
  end

  def get_t3!(id), do: Repo.get!(T3, id)

  def create_t3(attrs \\ %{}) do
    %T3{}
    |> T3.changeset(attrs)
    |> Repo.insert()
  end

  def update_t3(%T3{} = t3, attrs) do
    t3
    |> T3.changeset(attrs)
    |> Repo.update()
  end

  def delete_t3(%T3{} = t3) do
    Repo.delete(t3)
  end

  def change_t3(%T3{} = t3) do
    T3.changeset(t3, %{})
  end

  def buy_t3(t1_currency, amount_to_buy) do
    # entity = Repo.preload(gab_account, :entity).entity

    t3_list = [

    ]

    buying_amount = Decimal.div(amount_to_buy, 13)

    for {key, _value} <- t3_list,
        into: %{},
        do: {key, fx(:buy, key, t1_currency, buying_amount)}
  end

  def sell_t3(t1_currency, gab_account) do
    # t1_revenue_list = Enum.map(gab_account.t3, fn {key, value} -> fx(:sell, key, value, default_currency) end)
    t3_in_t1 =
      for {key, value} <- gab_account.t3,
          into: %{},
          do: {key, fx(:sell, key, value, t1_currency)}

    # Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
    Enum.reduce(t3_in_t1, 0, fn {_key, value}, acc -> Decimal.add(value, acc) end)
  end

  defp fx(:buy, _key, _t1_currency, buying_amount) do
    # ? buy index of each t3 as much as buying amount at the t3
    # ? dummy value
    buying_amount
  end

  defp fx(:sell, key, value, t1_currency) do
    # ? get the price of each index in t3 list, denoted by default_currency.
    index_price = get_index_price(key, t1_currency)
    Decimal.mult(index_price, value)
  end

  defp get_index_price(_index, _t1_currency) do
    # ? dummy data
    1
  end
end
