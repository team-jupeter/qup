defmodule Demo.Tels do
  @moduledoc """
  The Tels context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Tels.Tel

  @doc """
  Returns the list of tels.

  ## Examples

      iex> list_tels()
      [%Tel{}, ...]

  """
  def list_tels do
    Repo.all(Tel)
  end

  @doc """
  Gets a single tel.

  Raises `Ecto.NoResultsError` if the Tel does not exist.

  ## Examples

      iex> get_tel!(123)
      %Tel{}

      iex> get_tel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tel!(id), do: Repo.get!(Tel, id)

  @doc """
  Creates a tel.

  ## Examples

      iex> create_tel(%{field: value})
      {:ok, %Tel{}}

      iex> create_tel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tel(attrs \\ %{}) do
    %Tel{}
    |> Tel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tel.

  ## Examples

      iex> update_tel(tel, %{field: new_value})
      {:ok, %Tel{}}

      iex> update_tel(tel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tel(%Tel{} = tel, attrs) do
    tel
    |> Tel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tel.

  ## Examples

      iex> delete_tel(tel)
      {:ok, %Tel{}}

      iex> delete_tel(tel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tel(%Tel{} = tel) do
    Repo.delete(tel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tel changes.

  ## Examples

      iex> change_tel(tel)
      %Ecto.Changeset{source: %Tel{}}

  """
  def change_tel(%Tel{} = tel) do
    Tel.changeset(tel, %{})
  end
end
