defmodule Demo.CDCS do
  @moduledoc """
  The CDCS context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.CDCS.CDC

  @doc """
  Returns the list of cdcs.

  ## Examples

      iex> list_cdcs()
      [%CDC{}, ...]

  """
  def list_cdcs do
    Repo.all(CDC)
  end

  @doc """
  Gets a single cdc.

  Raises `Ecto.NoResultsError` if the Cdc does not exist.

  ## Examples

      iex> get_cdc!(123)
      %CDC{}

      iex> get_cdc!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cdc!(id), do: Repo.get!(CDC, id)

  @doc """
  Creates a cdc.

  ## Examples

      iex> create_cdc(%{field: value})
      {:ok, %CDC{}}

      iex> create_cdc(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cdc(attrs \\ %{}) do
    %CDC{}
    |> CDC.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cdc.

  ## Examples

      iex> update_cdc(cdc, %{field: new_value})
      {:ok, %CDC{}}

      iex> update_cdc(cdc, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cdc(%CDC{} = cdc, attrs) do
    cdc
    |> CDC.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cdc.

  ## Examples

      iex> delete_cdc(cdc)
      {:ok, %CDC{}}

      iex> delete_cdc(cdc)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cdc(%CDC{} = cdc) do
    Repo.delete(cdc)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cdc changes.

  ## Examples

      iex> change_cdc(cdc)
      %Ecto.Changeset{source: %CDC{}}

  """
  def change_cdc(%CDC{} = cdc) do
    CDC.changeset(cdc, %{})
  end
end
