defmodule Demo.T3s do


  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T3s.T3

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


  def get_t3_price() do
    #? dummy
    1 
  end
  
  def buy_t3(gab_account, quantity_to_buy) do
    #? return a list of bought t3s.
    result = for i <- 1..quantity_to_buy, do: create_t3(%{current_owner: entity}) 
    
  end

  def sell_t3(gab_account, quantity_to_sell) do    
    #? select the first t3 from the gab_account's t3 list, and change the current owner of t3s to sell to gab name.
    t3_to_sell = Enum.take(gab_account.t3, quantity_to_sell)
    Enum.map(t3_to_sell, fn t3 -> T3s.update_t3(t3, %{current_owner: nil}))
    
    remained_t3s = Enum.slice(gab_account.t3, quantity_to_sell..)
  
  end


end
