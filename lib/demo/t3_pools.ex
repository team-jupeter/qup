defmodule Demo.T3Pools do
  @moduledoc """
  The T3Pools context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T3Pools.T3Pool

  @doc """
  Returns the list of t3_pools.

  ## Examples

      iex> list_t3_pools()
      [%T3Pool{}, ...]

  """
  def list_t3_pools do
    Repo.all(T3Pool)
  end

  @doc """
  Gets a single t3_pool.

  Raises `Ecto.NoResultsError` if the T3 pool does not exist.

  ## Examples

      iex> get_t3_pool!(123)
      %T3Pool{}

      iex> get_t3_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t3_pool!(id), do: Repo.get!(T3Pool, id)

  @doc """
  Creates a t3_pool.

  ## Examples

      iex> create_t3_pool(%{field: value})
      {:ok, %T3Pool{}}

      iex> create_t3_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t3_pool(attrs \\ %{}) do
    %T3Pool{}
    |> T3Pool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t3_pool.

  ## Examples

      iex> update_t3_pool(t3_pool, %{field: new_value})
      {:ok, %T3Pool{}}

      iex> update_t3_pool(t3_pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t3_pool(%T3Pool{} = t3_pool, attrs) do
    t3_pool
    |> T3Pool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t3_pool.

  ## Examples

      iex> delete_t3_pool(t3_pool)
      {:ok, %T3Pool{}}

      iex> delete_t3_pool(t3_pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t3_pool(%T3Pool{} = t3_pool) do
    Repo.delete(t3_pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t3_pool changes.

  ## Examples

      iex> change_t3_pool(t3_pool)
      %Ecto.Changeset{source: %T3Pool{}}

  """
  def change_t3_pool(%T3Pool{} = t3_pool) do
    T3Pool.changeset(t3_pool, %{})
  end
end
