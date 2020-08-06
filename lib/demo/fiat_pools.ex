defmodule Demo.FiatPools do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.FiatPools.FiatPool

  def list_fiat_pools do
    Repo.all(FiatPool)
  end

  def get_fiat_pool!(id), do: Repo.get!(FiatPool, id)


  def create_fiat_pool(attrs \\ %{}) do
    %FiatPool{}
    |> FiatPool.changeset(attrs)
    |> Repo.insert()
  end

  def update_fiat_pool(%FiatPool{} = fiat_pool, attrs) do
    fiat_pool
    |> FiatPool.changeset(attrs)
    |> Repo.update()
  end

  def delete_fiat_pool(%FiatPool{} = fiat_pool) do
    Repo.delete(fiat_pool)
  end


  def change_fiat_pool(%FiatPool{} = fiat_pool) do
    FiatPool.changeset(fiat_pool, %{})
  end
end
