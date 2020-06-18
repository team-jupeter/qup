defmodule Demo.NationSupuls do
  @moduledoc """
  The NationSupuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.NationSupul

  @doc """
  Returns the list of nation_supuls.

  ## Examples

      iex> list_nation_supuls()
      [%NationSupul{}, ...]

  """
  def list_nation_supuls do
    Repo.all(NationSupul)
  end

  @doc """
  Gets a single nation_supul.

  Raises `Ecto.NoResultsError` if the Nation supul does not exist.

  ## Examples

      iex> get_nation_supul!(123)
      %NationSupul{}

      iex> get_nation_supul!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nation_supul!(id), do: Repo.get!(NationSupul, id)

  @doc """
  Creates a nation_supul.

  ## Examples

      iex> create_nation_supul(%{field: value})
      {:ok, %NationSupul{}}

      iex> create_nation_supul(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nation_supul(attrs \\ %{}) do
    %NationSupul{}
    |> NationSupul.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nation_supul.

  ## Examples

      iex> update_nation_supul(nation_supul, %{field: new_value})
      {:ok, %NationSupul{}}

      iex> update_nation_supul(nation_supul, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nation_supul(%NationSupul{} = nation_supul, attrs) do
    nation_supul
    |> NationSupul.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nation_supul.

  ## Examples

      iex> delete_nation_supul(nation_supul)
      {:ok, %NationSupul{}}

      iex> delete_nation_supul(nation_supul)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nation_supul(%NationSupul{} = nation_supul) do
    Repo.delete(nation_supul)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nation_supul changes.

  ## Examples

      iex> change_nation_supul(nation_supul)
      %Ecto.Changeset{source: %NationSupul{}}

  """
  def change_nation_supul(%NationSupul{} = nation_supul) do
    NationSupul.changeset(nation_supul, %{})
  end
end
