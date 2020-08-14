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


  def create_supul_gab(attrs \\ %{}) do
    pools = pools(attrs.name)
    attrs = Map.merge(pools, attrs)
    %Gab{}
    |> Gab.changeset_supul(attrs)
    |> Repo.insert()
  end

  def create_state_supul_gab(attrs \\ %{}) do
    pools = pools(attrs.name)
    attrs = Map.merge(pools, attrs)
    %Gab{}
    |> Gab.changeset_state_supul(attrs)
    |> Repo.insert()
  end

  def create_nation_supul_gab(attrs \\ %{}) do
    pools = pools(attrs.name)
    attrs = Map.merge(pools, attrs)
    %Gab{}
    |> Gab.changeset_nation_supul(attrs)
    |> Repo.insert()
  end


  defp pools(name) do
    t1_pool = T1Pool.changeset(%T1Pool{}, %{name: name})
    t2_pool = T2Pool.changeset(%T2Pool{}, %{name: name})
    t3_pool = T3Pool.changeset(%T3Pool{}, %{name: name})
    t4_pool = T4Pool.changeset(%T4Pool{}, %{name: name})
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
