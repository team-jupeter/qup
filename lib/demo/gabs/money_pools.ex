defmodule Demo.MoneyPools do
  @moduledoc """
  The MoneyPools context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.MoneyPools.MoneyPool

  @doc """
  Returns the list of money_pools.

  ## Examples

      iex> list_money_pools()
      [%MoneyPool{}, ...]

  """
  def list_money_pools do
    Repo.all(MoneyPool)
  end

  @doc """
  Gets a single money_pool.

  Raises `Ecto.NoResultsError` if the Money pool does not exist.

  ## Examples

      iex> get_money_pool!(123)
      %MoneyPool{}

      iex> get_money_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_money_pool!(id), do: Repo.get!(MoneyPool, id)

  @doc """
  Creates a money_pool.

  ## Examples

      iex> create_money_pool(%{field: value})
      {:ok, %MoneyPool{}}

      iex> create_money_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_money_pool(attrs \\ %{}) do
    %MoneyPool{}
    |> MoneyPool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a money_pool.

  ## Examples

      iex> update_money_pool(money_pool, %{field: new_value})
      {:ok, %MoneyPool{}}

      iex> update_money_pool(money_pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_money_pool(%MoneyPool{} = money_pool, attrs) do
    money_pool
    |> MoneyPool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a money_pool.

  ## Examples

      iex> delete_money_pool(money_pool)
      {:ok, %MoneyPool{}}

      iex> delete_money_pool(money_pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_money_pool(%MoneyPool{} = money_pool) do
    Repo.delete(money_pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking money_pool changes.

  ## Examples

      iex> change_money_pool(money_pool)
      %Ecto.Changeset{source: %MoneyPool{}}

  """
  def change_money_pool(%MoneyPool{} = money_pool) do
    MoneyPool.changeset(money_pool, %{})
  end
end
