defmodule Demo.T2Pools do
  @moduledoc """
  The T2Pools context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T2Pools.T2Pool

  @doc """
  Returns the list of t2_pools.

  ## Examples

      iex> list_t2_pools()
      [%T2Pool{}, ...]

  """
  def list_t2_pools do
    Repo.all(T2Pool)
  end

  @doc """
  Gets a single t2_pool.

  Raises `Ecto.NoResultsError` if the T2 pool does not exist.

  ## Examples

      iex> get_t2_pool!(123)
      %T2Pool{}

      iex> get_t2_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t2_pool!(id), do: Repo.get!(T2Pool, id)

  @doc """
  Creates a t2_pool.

  ## Examples

      iex> create_t2_pool(%{field: value})
      {:ok, %T2Pool{}}

      iex> create_t2_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t2_pool(attrs \\ %{}) do
    %T2Pool{}
    |> T2Pool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t2_pool.

  ## Examples

      iex> update_t2_pool(t2_pool, %{field: new_value})
      {:ok, %T2Pool{}}

      iex> update_t2_pool(t2_pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t2_pool(%T2Pool{} = t2_pool, attrs) do
    t2_pool
    |> T2Pool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t2_pool.

  ## Examples

      iex> delete_t2_pool(t2_pool)
      {:ok, %T2Pool{}}

      iex> delete_t2_pool(t2_pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t2_pool(%T2Pool{} = t2_pool) do
    Repo.delete(t2_pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t2_pool changes.

  ## Examples

      iex> change_t2_pool(t2_pool)
      %Ecto.Changeset{source: %T2Pool{}}

  """
  def change_t2_pool(%T2Pool{} = t2_pool) do
    T2Pool.changeset(t2_pool, %{})
  end
end
