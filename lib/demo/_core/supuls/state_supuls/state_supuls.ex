defmodule Demo.StateSupuls do
  @moduledoc """
  The StateSupuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.StateSupul

  @doc """
  Returns the list of state_supuls.

  ## Examples

      iex> list_state_supuls()
      [%StateSupul{}, ...]

  """
  def list_state_supuls do
    Repo.all(StateSupul)
  end

  @doc """
  Gets a single state_supul.

  Raises `Ecto.NoResultsError` if the State supul does not exist.

  ## Examples

      iex> get_state_supul!(123)
      %StateSupul{}

      iex> get_state_supul!(456)
      ** (Ecto.NoResultsError)

  """
  def get_state_supul!(id), do: Repo.get!(StateSupul, id)

  @doc """
  Creates a state_supul.

  ## Examples

      iex> create_state_supul(%{field: value})
      {:ok, %StateSupul{}}

      iex> create_state_supul(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_state_supul(attrs \\ %{}) do
    %StateSupul{}
    |> StateSupul.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a state_supul.

  ## Examples

      iex> update_state_supul(state_supul, %{field: new_value})
      {:ok, %StateSupul{}}

      iex> update_state_supul(state_supul, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_state_supul(%StateSupul{} = state_supul, attrs) do
    state_supul
    |> StateSupul.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a state_supul.

  ## Examples

      iex> delete_state_supul(state_supul)
      {:ok, %StateSupul{}}

      iex> delete_state_supul(state_supul)
      {:error, %Ecto.Changeset{}}

  """
  def delete_state_supul(%StateSupul{} = state_supul) do
    Repo.delete(state_supul)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking state_supul changes.

  ## Examples

      iex> change_state_supul(state_supul)
      %Ecto.Changeset{source: %StateSupul{}}

  """
  def change_state_supul(%StateSupul{} = state_supul) do
    StateSupul.changeset(state_supul, %{})
  end
end
