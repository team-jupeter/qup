defmodule Demo.T2Lists do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T2Lists.T2List

  def list_t2_lists do
    Repo.all(T2List)
  end


  def get_t2_list!(id), do: Repo.get!(T2List, id)


  def create_t2_list(attrs \\ %{}) do
    %T2List{}
    |> T2List.changeset(attrs)
    |> Repo.insert()
  end


  def update_t2_list(%T2List{} = t2_list, attrs) do
    t2_list
    |> T2List.changeset(attrs)
    |> Repo.update()
  end


  def delete_t2_list(%T2List{} = t2_list) do
    Repo.delete(t2_list)
  end


  def change_t2_list(%T2List{} = t2_list) do
    T2List.changeset(t2_list, %{})
  end

  def buy_t2(fiat_to_sell, amount) do
    fiat_list_to_buy = [USD, EUR, JPY, GBP, AUD, CAD, CHF, CNY, SEK, MXN, NZD, SGD, HKD, NOK, KRW]
    buying_amount_per_fiat = Decimal.div(amount, 15)
    t2 = Enum.map(fiat_list_to_buy, fn fiat_to_buy -> fx(fiat_to_sell, fiat_to_buy, buying_amount_per_fiat))
  end

  def sell_t2(gab_account, amount_to_sell) do
    fiat_to_buy = gab_account.default_currency
    t1 = Enum.map(t2, fn fiat, amount -> fx(fiat, amount, fiat_to_buy))
    new_t1_amount = Enum.reduce(t1, 0, fn t, acc -> Decimal.add(t, acc))
  end

  defp fx(fiat, amount, fiat_to_buy) do
    #? sell fiat at FX market, and return a list

  end
end
