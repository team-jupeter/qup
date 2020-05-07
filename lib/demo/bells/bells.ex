defmodule Demo.Bells do
  @moduledoc """
  The Bells context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Bells.Bell

  @doc """
  Returns the list of bells.

  ## Examples

      iex> list_bells()
      [%Bell{}, ...]

  """
  def list_bells do
    Repo.all(Bell)
  end

  @doc """
  Gets a single bell.

  Raises `Ecto.NoResultsError` if the Bell does not exist.

  ## Examples

      iex> get_bell!(123)
      %Bell{}

      iex> get_bell!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bell!(id), do: Repo.get!(Bell, id)

  @doc """
  Creates a bell.

  ## Examples

      iex> create_bell(%{field: value})
      {:ok, %Bell{}}

      iex> create_bell(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bell(attrs \\ %{}) do
    %Bell{}
    |> Bell.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bell.

  ## Examples

      iex> update_bell(bell, %{field: new_value})
      {:ok, %Bell{}}

      iex> update_bell(bell, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bell(%Bell{} = bell, attrs) do
    bell
    |> Bell.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bell.

  ## Examples

      iex> delete_bell(bell)
      {:ok, %Bell{}}

      iex> delete_bell(bell)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bell(%Bell{} = bell) do
    Repo.delete(bell)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bell changes.

  ## Examples

      iex> change_bell(bell)
      %Ecto.Changeset{source: %Bell{}}

  """
  def change_bell(%Bell{} = bell) do
    Bell.changeset(bell, %{})
  end
end
