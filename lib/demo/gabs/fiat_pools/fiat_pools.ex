defmodule Demo.FiatPools do
  @moduledoc """
  The FiatPools context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.FiatPools.FiatPool

  @doc """
  Returns the list of fiat_pools.

  ## Examples

      iex> list_fiat_pools()
      [%FiatPool{}, ...]

  """
  def list_fiat_pools do
    Repo.all(FiatPool)
  end

  @doc """
  Gets a single fiat_pool.

  Raises `Ecto.NoResultsError` if the Money pool does not exist.

  ## Examples

      iex> get_fiat_pool!(123)
      %FiatPool{}

      iex> get_fiat_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fiat_pool!(id), do: Repo.get!(FiatPool, id)

  @doc """
  Creates a fiat_pool.

  ## Examples

      iex> create_fiat_pool(%{field: value})
      {:ok, %FiatPool{}}

      iex> create_fiat_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fiat_pool(attrs \\ %{}) do
    %FiatPool{}
    |> FiatPool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fiat_pool.

  ## Examples

      iex> update_fiat_pool(fiat_pool, %{field: new_value})
      {:ok, %FiatPool{}}

      iex> update_fiat_pool(fiat_pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fiat_pool(%FiatPool{} = fiat_pool, attrs) do
    fiat_pool
    |> FiatPool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fiat_pool.

  ## Examples

      iex> delete_fiat_pool(fiat_pool)
      {:ok, %FiatPool{}}

      iex> delete_fiat_pool(fiat_pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fiat_pool(%FiatPool{} = fiat_pool) do
    Repo.delete(fiat_pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fiat_pool changes.

  ## Examples

      iex> change_fiat_pool(fiat_pool)
      %Ecto.Changeset{source: %FiatPool{}}

  """
  def change_fiat_pool(%FiatPool{} = fiat_pool) do
    FiatPool.changeset(fiat_pool, %{})
  end
end
