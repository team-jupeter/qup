defmodule Demo.T1Lists do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T1Lists.T1List


  def list_t1_lists do
    Repo.all(T1List)
  end


  def get_t1_list!(id), do: Repo.get!(T1List, id)


  def create_t1_list(attrs \\ %{}) do
    %T1List{}
    |> T1List.changeset(attrs)
    |> Repo.insert()
  end


  def update_t1_list(%T1List{} = t1_list, attrs) do
    t1_list
    |> T1List.changeset(attrs)
    |> Repo.update()
  end


  def delete_t1_list(%T1List{} = t1_list) do
    Repo.delete(t1_list)
  end

 
  def change_t1_list(%T1List{} = t1_list) do
    T1List.changeset(t1_list, %{})
  end

  def exchange_t1(fiat_to_sell, fiat_to_buy, t1_balance) do
    fx_rate = Gabs.get_fx_rate(fiat_to_sell, fiat_to_buy)
    new_t1_balance = Decimal.mult(fx_rate, t1_balance)
    new_t1 = %T1{
      input: entity.name,
      output: entity.name,
      amount: new_t1_balance,
      currency: fiat_to_buy
    }
  end


end
