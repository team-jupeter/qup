defmodule Demo.Patents do
  @moduledoc """
  The Patents context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Patents.Patent

  @doc """
  Returns the list of patents.

  ## Examples

      iex> list_patents()
      [%Patent{}, ...]

  """
  def list_patents do
    Repo.all(Patent)
  end

  @doc """
  Gets a single patent.

  Raises `Ecto.NoResultsError` if the Patent does not exist.

  ## Examples

      iex> get_patent!(123)
      %Patent{}

      iex> get_patent!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patent!(id), do: Repo.get!(Patent, id)

  @doc """
  Creates a patent.

  ## Examples

      iex> create_patent(%{field: value})
      {:ok, %Patent{}}

      iex> create_patent(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patent(attrs \\ %{}) do
    %Patent{}
    |> Patent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patent.

  ## Examples

      iex> update_patent(patent, %{field: new_value})
      {:ok, %Patent{}}

      iex> update_patent(patent, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patent(%Patent{} = patent, attrs) do
    patent
    |> Patent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patent.

  ## Examples

      iex> delete_patent(patent)
      {:ok, %Patent{}}

      iex> delete_patent(patent)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patent(%Patent{} = patent) do
    Repo.delete(patent)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patent changes.

  ## Examples

      iex> change_patent(patent)
      %Ecto.Changeset{source: %Patent{}}

  """
  def change_patent(%Patent{} = patent) do
    Patent.changeset(patent, %{})
  end
end
