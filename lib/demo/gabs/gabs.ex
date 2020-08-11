defmodule Demo.Gabs do


  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Gabs.Gab
  alias Demo.T1Pools.T1Pool
  alias Demo.T2Pools.T2Pool
  alias Demo.T3Pools.T3Pool
  alias Demo.T4Pools.T4Pool



  def list_gabs do
    Repo.all(Gab)
  end


  def get_gab!(id), do: Repo.get!(Gab, id)


  def create_gab(attrs \\ %{}) do
    attrs = pools()
    %Gab{}
    |> Gab.changeset(attrs)
    |> Repo.insert()
  end


  defp pools() do
    t1_pool = %T1Pool{}
    t2_pool = %T2Pool{}
    t3_pool = %T3Pool{}
    t4_pool = %T4Pool{}
    %{t1_pool: t1_pool, t2_pool: t2_pool, t3_pool: t3_pool, t4_pool: t4_pool}
  end

  def update_gab(%Gab{} = gab, attrs) do
    gab 
    |> Gab.changeset(attrs)
    |> Repo.update()
  end

  def delete_gab(%Gab{} = gab) do
    Repo.delete(gab)
  end


  def change_gab(%Gab{} = gab) do
    Gab.changeset(gab, %{})
  end

  def get_ex_rate(currency_one, currency_two, amount) do
    #? return dummy data
    amount
  end
end
