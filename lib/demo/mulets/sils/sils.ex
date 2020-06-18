defmodule Demo.Sils do
  @moduledoc """
  The Sils context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Sils.Sil

  @doc """
  Returns the list of sils.

  ## Examples

      iex> list_sils()
      [%Sil{}, ...]

  """
  def list_sils do
    Repo.all(Sil)
  end

  @doc """
  Gets a single sil.

  Raises `Ecto.NoResultsError` if the Sil does not exist.

  ## Examples

      iex> get_sil!(123)
      %Sil{}

      iex> get_sil!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sil!(id), do: Repo.get!(Sil, id)

  @doc """
  Creates a sil.

  ## Examples

      iex> create_sil(%{field: value})
      {:ok, %Sil{}}

      iex> create_sil(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sil(attrs \\ %{}) do
    %Sil{}
    |> Sil.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sil.

  ## Examples

      iex> update_sil(sil, %{field: new_value})
      {:ok, %Sil{}}

      iex> update_sil(sil, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sil(%Sil{} = sil, attrs) do
    sil
    |> Sil.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sil.

  ## Examples

      iex> delete_sil(sil)
      {:ok, %Sil{}}

      iex> delete_sil(sil)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sil(%Sil{} = sil) do
    Repo.delete(sil)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sil changes.

  ## Examples

      iex> change_sil(sil)
      %Ecto.Changeset{source: %Sil{}}

  """
  def change_sil(%Sil{} = sil) do
    Sil.changeset(sil, %{})
  end
end
