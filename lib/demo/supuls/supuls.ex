defmodule Demo.Supuls do
  @moduledoc """
  The Supuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.UnitSupul

  @doc """
  Returns the list of unit_supuls.

  ## Examples

      iex> list_unit_supuls()
      [%UnitSupul{}, ...]

  """
  def list_unit_supuls do
    Repo.all(UnitSupul)
  end

  @doc """
  Gets a single unit_supul.

  Raises `Ecto.NoResultsError` if the Unit supul does not exist.

  ## Examples

      iex> get_unit_supul!(123)
      %UnitSupul{}

      iex> get_unit_supul!(456)
      ** (Ecto.NoResultsError)

  """
  def get_unit_supul!(id), do: Repo.get!(UnitSupul, id)

  @doc """
  Creates a unit_supul.

  ## Examples

      iex> create_unit_supul(%{field: value})
      {:ok, %UnitSupul{}}

      iex> create_unit_supul(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_unit_supul(attrs \\ %{}) do
    %UnitSupul{}
    |> UnitSupul.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a unit_supul.

  ## Examples

      iex> update_unit_supul(unit_supul, %{field: new_value})
      {:ok, %UnitSupul{}}

      iex> update_unit_supul(unit_supul, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_unit_supul(%UnitSupul{} = unit_supul, attrs) do
    unit_supul
    |> UnitSupul.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a unit_supul.

  ## Examples

      iex> delete_unit_supul(unit_supul)
      {:ok, %UnitSupul{}}

      iex> delete_unit_supul(unit_supul)
      {:error, %Ecto.Changeset{}}

  """
  def delete_unit_supul(%UnitSupul{} = unit_supul) do
    Repo.delete(unit_supul)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking unit_supul changes.

  ## Examples

      iex> change_unit_supul(unit_supul)
      %Ecto.Changeset{source: %UnitSupul{}}

  """
  def change_unit_supul(%UnitSupul{} = unit_supul) do
    UnitSupul.changeset(unit_supul, %{})
  end
end
