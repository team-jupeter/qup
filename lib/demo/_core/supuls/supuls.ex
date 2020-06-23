defmodule Demo.Supuls do
  @moduledoc """
  The Supuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul

  @doc """
  Returns the list of supuls.

  ## Examples

      iex> list_supuls()
      [%Supul{}, ...]

  """
  def list_supuls do
    Repo.all(Supul)
  end

  @doc """
  Gets a single supul.

  Raises `Ecto.NoResultsError` if the Supul does not exist.

  ## Examples

      iex> get_supul!(123)
      %Supul{}

      iex> get_supul!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supul!(id), do: Repo.get!(Supul, id)

  @doc """
  Creates a supul.

  ## Examples

      iex> create_supul(%{field: value})
      {:ok, %Supul{}}

      iex> create_supul(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supul(attrs \\ %{}) do
    %Supul{}
    |> Supul.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supul.

  ## Examples

      iex> update_supul(supul, %{field: new_value})
      {:ok, %Supul{}}

      iex> update_supul(supul, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supul(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supul.

  ## Examples

      iex> delete_supul(supul)
      {:ok, %Supul{}}

      iex> delete_supul(supul)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supul(%Supul{} = supul) do
    Repo.delete(supul)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supul changes.

  ## Examples

      iex> change_supul(supul)
      %Ecto.Changeset{source: %Supul{}}

  """
  def change_supul(%Supul{} = supul) do
    Supul.changeset(supul, %{})
  end
end
