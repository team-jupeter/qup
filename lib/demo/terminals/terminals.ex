defmodule Demo.Terminals do
  @moduledoc """
  The Terminals context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Terminals.Terminal

  @doc """
  Returns the list of terminals.

  ## Examples

      iex> list_terminals()
      [%Terminal{}, ...]

  """
  def list_terminals do
    Repo.all(Terminal)
  end

  @doc """
  Gets a single terminal.

  Raises `Ecto.NoResultsError` if the Terminal does not exist.

  ## Examples

      iex> get_terminal!(123)
      %Terminal{}

      iex> get_terminal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_terminal!(id), do: Repo.get!(Terminal, id)

  @doc """
  Creates a terminal.

  ## Examples

      iex> create_terminal(%{field: value})
      {:ok, %Terminal{}}

      iex> create_terminal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_terminal(attrs \\ %{}) do
    %Terminal{}
    |> Terminal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a terminal.

  ## Examples

      iex> update_terminal(terminal, %{field: new_value})
      {:ok, %Terminal{}}

      iex> update_terminal(terminal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_terminal(%Terminal{} = terminal, attrs) do
    terminal
    |> Terminal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a terminal.

  ## Examples

      iex> delete_terminal(terminal)
      {:ok, %Terminal{}}

      iex> delete_terminal(terminal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_terminal(%Terminal{} = terminal) do
    Repo.delete(terminal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking terminal changes.

  ## Examples

      iex> change_terminal(terminal)
      %Ecto.Changeset{source: %Terminal{}}

  """
  def change_terminal(%Terminal{} = terminal) do
    Terminal.changeset(terminal, %{})
  end
end
