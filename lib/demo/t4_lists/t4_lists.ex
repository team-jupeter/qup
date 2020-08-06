defmodule Demo.T4Lists do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T4Lists.T4List

  def list_t4_lists do
    Repo.all(T4List)
  end

  def get_t4_list!(id), do: Repo.get!(T4List, id)

  def create_t4_list(attrs \\ %{}) do
    %T4List{}
    |> T4List.changeset(attrs)
    |> Repo.insert()
  end

  def update_t4_list(%T4List{} = t4_list, attrs) do
    t4_list
    |> T4List.changeset(attrs)
    |> Repo.update()
  end

  def delete_t4_list(%T4List{} = t4_list) do
    Repo.delete(t4_list)
  end

  def change_t4_list(%T4List{} = t4_list) do
    T4List.changeset(t4_list, %{})
  end

  def buy_t4(gab_account, fiat_name, amount_to_buy) do
    exchange_list = [:NYSE, :NASDAQ, :JPX, :LSE, :SSE, :SEHK, :ENX, :SZSE, :TSX, :BSE, :NSE, :DB, :SIX, :KRX]
    buying_amount = Decimal.div(amount_to_buy, 14)
    bought_t4 = Enum.map(exchange_list, fn each, buying_amount -> fx(:buy, each, buying_amount))
  end
 
  def sell_t4(gab_account, amount_to_sell) do
    fiat_to_buy = gab_account.default_currency
    t1_revenue_list = Enum.map(t4, fn index, amount -> fx(index, amount, fiat_to_buy))
    
    #? initialize T4 of the gab_account.
    init_t4 = %T4{}
    GabAccounts.update_gab_account(gab_account, %{t4: init_t4})

    total_t1_revenue = Enum.reduce(t1, 0, fn t, acc -> Decimal.add(t, acc))
  end

  defp fx(:buy, each, amount) do
    #? buy index of each exchange as much as buying amount
    #? Return map
  end

  defp fx(index, amount, fiat_to_buy) do
    #? sell index of each exchange index as much as its amount
    #? Return map
  end
end
