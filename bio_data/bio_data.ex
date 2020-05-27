defmodule Demo.BioData do
  @moduledoc """
  The BioData context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.BioData.BioDatum

  @doc """
  Returns the list of usweight.

  ## Examples

      iex> list_usweight()
      [%BioDatum{}, ...]

  """
  def list_usweight do
    Repo.all(BioDatum)
  end

  @doc """
  Gets a single bio_datum.

  Raises `Ecto.NoResultsError` if the Bio datum does not exist.

  ## Examples

      iex> get_bio_datum!(123)
      %BioDatum{}

      iex> get_bio_datum!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bio_datum!(id), do: Repo.get!(BioDatum, id)

  @doc """
  Creates a bio_datum.

  ## Examples

      iex> create_bio_datum(%{field: value})
      {:ok, %BioDatum{}}

      iex> create_bio_datum(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bio_datum(attrs \\ %{}) do
    %BioDatum{}
    |> BioDatum.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bio_datum.

  ## Examples

      iex> update_bio_datum(bio_datum, %{field: new_value})
      {:ok, %BioDatum{}}

      iex> update_bio_datum(bio_datum, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bio_datum(%BioDatum{} = bio_datum, attrs) do
    bio_datum
    |> BioDatum.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bio_datum.

  ## Examples

      iex> delete_bio_datum(bio_datum)
      {:ok, %BioDatum{}}

      iex> delete_bio_datum(bio_datum)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bio_datum(%BioDatum{} = bio_datum) do
    Repo.delete(bio_datum)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bio_datum changes.

  ## Examples

      iex> change_bio_datum(bio_datum)
      %Ecto.Changeset{source: %BioDatum{}}

  """
  def change_bio_datum(%BioDatum{} = bio_datum) do
    BioDatum.changeset(bio_datum, %{})
  end
end
