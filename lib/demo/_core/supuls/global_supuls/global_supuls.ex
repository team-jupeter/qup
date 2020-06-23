defmodule Demo.GlobalSupuls do
  @moduledoc """
  The GlobalSupuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.GlobalSupul

  @doc """
  Returns the list of global_supuls.

  ## Examples

      iex> list_global_supuls()
      [%GlobalSupul{}, ...]

  """
  def list_global_supuls do
    Repo.all(GlobalSupul)
  end

  @doc """
  Gets a single global_supul.

  Raises `Ecto.NoResultsError` if the Global supul does not exist.

  ## Examples

      iex> get_global_supul!(123)
      %GlobalSupul{}

      iex> get_global_supul!(456)
      ** (Ecto.NoResultsError)

  """
  def get_global_supul!(id), do: Repo.get!(GlobalSupul, id)

  @doc """
  Creates a global_supul.

  ## Examples

      iex> create_global_supul(%{field: value})
      {:ok, %GlobalSupul{}}

      iex> create_global_supul(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_global_supul(attrs \\ %{}) do
    %GlobalSupul{}
    |> GlobalSupul.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a global_supul.

  ## Examples

      iex> update_global_supul(global_supul, %{field: new_value})
      {:ok, %GlobalSupul{}}

      iex> update_global_supul(global_supul, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_global_supul(%GlobalSupul{} = global_supul, attrs) do
    global_supul
    |> GlobalSupul.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a global_supul.

  ## Examples

      iex> delete_global_supul(global_supul)
      {:ok, %GlobalSupul{}}

      iex> delete_global_supul(global_supul)
      {:error, %Ecto.Changeset{}}

  """
  def delete_global_supul(%GlobalSupul{} = global_supul) do
    Repo.delete(global_supul)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking global_supul changes.

  ## Examples

      iex> change_global_supul(global_supul)
      %Ecto.Changeset{source: %GlobalSupul{}}

  """
  def change_global_supul(%GlobalSupul{} = global_supul) do
    GlobalSupul.changeset(global_supul, %{})
  end
end
