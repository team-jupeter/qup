defmodule Demo.T1Pools do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T1Pools.T1Pool

  def list_t1_pools do
    Repo.all(T1Pool)
  end

  def get_t1_pool!(id), do: Repo.get!(T1Pool, id)

  def create_t1_pool(attrs \\ %{}) do
    %T1Pool{}
    |> T1Pool.changeset(attrs)
    |> Repo.insert()
  end

  def update_t1_pool(%T1Pool{} = t1_pool, attrs) do
    t1_pool
    |> T1Pool.changeset(attrs)
    |> Repo.update()
  end

  def delete_t1_pool(%T1Pool{} = t1_pool) do
    Repo.delete(t1_pool)
  end
 
  def change_t1_pool(%T1Pool{} = t1_pool) do
    T1Pool.changeset(t1_pool, %{})
  end
end
