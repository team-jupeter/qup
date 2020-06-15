defmodule Demo.Mulets do
  @moduledoc """
  The Mulets context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Mulets.Mulet

  @doc """
  Returns the list of mulets.

  ## Examples

      iex> list_mulets()
      [%Mulet{}, ...]

  """
  def list_mulets do
    Repo.all(Mulet)
  end

  @doc """
  Gets a single mulet.

  Raises `Ecto.NoResultsError` if the Mulet does not exist.

  ## Examples

      iex> get_mulet!(123)
      %Mulet{}

      iex> get_mulet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mulet!(id), do: Repo.get!(Mulet, id)

  @doc """
  Creates a mulet.

  ## Examples

      iex> create_mulet(%{field: value})
      {:ok, %Mulet{}}

      iex> create_mulet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mulet(attrs \\ %{}) do
    %Mulet{}
    |> Mulet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mulet.

  ## Examples

      iex> update_mulet(mulet, %{field: new_value})
      {:ok, %Mulet{}}

      iex> update_mulet(mulet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mulet(%Mulet{} = mulet, attrs) do
    mulet
    |> Mulet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mulet.

  ## Examples

      iex> delete_mulet(mulet)
      {:ok, %Mulet{}}

      iex> delete_mulet(mulet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mulet(%Mulet{} = mulet) do
    Repo.delete(mulet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mulet changes.

  ## Examples

      iex> change_mulet(mulet)
      %Ecto.Changeset{source: %Mulet{}}

  """
  def change_mulet(%Mulet{} = mulet) do
    Mulet.changeset(mulet, %{})
  end
end
