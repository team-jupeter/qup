defmodule Demo.T4Pools do
  @moduledoc """
  The T4Pools context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T4Pools.T4Pool

  @doc """
  Returns the list of t4_pools.

  ## Examples

      iex> list_t4_pools()
      [%T4Pool{}, ...]

  """
  def list_t4_pools do
    Repo.all(T4Pool)
  end

  @doc """
  Gets a single t4_pool.

  Raises `Ecto.NoResultsError` if the T4 pool does not exist.

  ## Examples

      iex> get_t4_pool!(123)
      %T4Pool{}

      iex> get_t4_pool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t4_pool!(id), do: Repo.get!(T4Pool, id)

  @doc """
  Creates a t4_pool.

  ## Examples

      iex> create_t4_pool(%{field: value})
      {:ok, %T4Pool{}}

      iex> create_t4_pool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t4_pool(attrs \\ %{}) do
    %T4Pool{}
    |> T4Pool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t4_pool.

  ## Examples

      iex> update_t4_pool(t4_pool, %{field: new_value})
      {:ok, %T4Pool{}}

      iex> update_t4_pool(t4_pool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t4_pool(%T4Pool{} = t4_pool, attrs) do
    t4_pool
    |> T4Pool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t4_pool.

  ## Examples

      iex> delete_t4_pool(t4_pool)
      {:ok, %T4Pool{}}

      iex> delete_t4_pool(t4_pool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t4_pool(%T4Pool{} = t4_pool) do
    Repo.delete(t4_pool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t4_pool changes.

  ## Examples

      iex> change_t4_pool(t4_pool)
      %Ecto.Changeset{source: %T4Pool{}}

  """
  def change_t4_pool(%T4Pool{} = t4_pool) do
    T4Pool.changeset(t4_pool, %{})
  end
end
