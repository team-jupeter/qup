defmodule Demo.T1Pools do
  @moduledoc """
  The T1Pools context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T1Pools.T1Pool

  @doc """
  Returns the list of t1_pools.

  ## Examples

      iex> list_t1_pools()
      [%T1Pool{}, ...]

  """
  def list_t1_pools do
    Repo.all(T1Pool)
  end

  @doc """
  Gets a single t1_pool.

  Raises `Ecto.NoResultsError` if the T1 pool does not exist.

  ## Examples

      iex> get_t1_pool!(123)
      %T1Pool{}

      iex> get_t1_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t1_pool!(id), do: Repo.get!(T1Pool, id)

  @doc """
  Creates a t1_pool.

  ## Examples

      iex> create_t1_pool(%{field: value})
      {:ok, %T1Pool{}}

      iex> create_t1_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t1_pool(attrs \\ %{}) do
    %T1Pool{}
    |> T1Pool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t1_pool.

  ## Examples

      iex> update_t1_pool(t1_pool, %{field: new_value})
      {:ok, %T1Pool{}}

      iex> update_t1_pool(t1_pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t1_pool(%T1Pool{} = t1_pool, attrs) do
    t1_pool
    |> T1Pool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t1_pool.

  ## Examples

      iex> delete_t1_pool(t1_pool)
      {:ok, %T1Pool{}}

      iex> delete_t1_pool(t1_pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t1_pool(%T1Pool{} = t1_pool) do
    Repo.delete(t1_pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t1_pool changes.

  ## Examples

      iex> change_t1_pool(t1_pool)
      %Ecto.Changeset{source: %T1Pool{}}

  """
  def change_t1_pool(%T1Pool{} = t1_pool) do
    T1Pool.changeset(t1_pool, %{})
  end
end
