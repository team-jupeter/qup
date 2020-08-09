defmodule Demo.T1s do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T1s.T1
  alias Demo.GabAccounts


  def list_t1s do
    Repo.all(T1)
  end


  def get_t1!(id), do: Repo.get!(T1, id)


  def create_t1(attrs \\ %{}) do
    %T1{}
    |> T1.changeset(attrs)
    |> Repo.insert()
  end


  def update_t1(%T1{} = t1, attrs) do
    t1
    |> T1.changeset(attrs)
    |> Repo.update()
  end


  def delete_t1(%T1{} = t1) do
    Repo.delete(t1)
  end

 
  def change_t1(%T1{} = t1) do
    T1.changeset(t1, %{})
  end

  # def exchange_t1(gab_account, from_fiat, to_fiat) do    
  #   fx_rate = GabAccounts.get_fx_rate(from_fiat, to_fiat)
  #   Decimal.mult(fx_rate, gab_account.t1_balance)

  # end
end
