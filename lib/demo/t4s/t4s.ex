defmodule Demo.T4s do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T4s.T4
  # alias Demo.T1s.T1

  def list_t4s do
    Repo.all(T4)
  end

  def get_t4!(id), do: Repo.get!(T4, id)

  def create_t4(attrs \\ %{}) do
    %T4{}
    |> T4.changeset(attrs)
    |> Repo.insert()
  end

  def update_t4(%T4{} = t4, attrs) do
    t4
    |> T4.changeset(attrs)
    |> Repo.update()
  end

  def delete_t4(%T4{} = t4) do
    Repo.delete(t4)
  end

  def change_t4(%T4{} = t4) do
    T4.changeset(t4, %{})
  end

  def buy_t4(t1_currency, amount_to_buy) do
    # entity = Repo.preload(gab_account, :entity).entity

    exchange_list = [
      :nyse,
      :nasdaq,
      :jpx,
      :lse,
      :sse,
      :sehk,
      :enx,
      :szse,
      :tsx,
      :BSE,
      :nse,
      :db,
      :six,
      :krx
    ]

    buying_amount = Decimal.div(amount_to_buy, 14)

    for {key, _value} <- exchange_list,
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
    Decimal.mult(index_price, value)
  end

  defp get_index_price(_index, _t1_currency) do
    # ? dummy data
    1
  end
end
