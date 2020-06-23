defmodule Demo.Licenses do
  @moduledoc """
  The Licenses context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Licenses.License

  @doc """
  Returns the list of licenses.

  ## Examples

      iex> list_licenses()
      [%License{}, ...]

  """
  def list_licenses do
    Repo.all(License)
  end

  @doc """
  Gets a single license.

  Raises `Ecto.NoResultsError` if the License does not exist.

  ## Examples

      iex> get_license!(123)
      %License{}

      iex> get_license!(456)
      ** (Ecto.NoResultsError)

  """
  def get_license!(id), do: Repo.get!(License, id)

  @doc """
  Creates a license.

  ## Examples

      iex> create_license(%{field: value})
      {:ok, %License{}}

      iex> create_license(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_license(attrs \\ %{}) do
    %License{}
    |> License.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a license.

  ## Examples

      iex> update_license(license, %{field: new_value})
      {:ok, %License{}}

      iex> update_license(license, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_license(%License{} = license, attrs) do
    license
    |> License.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a license.

  ## Examples

      iex> delete_license(license)
      {:ok, %License{}}

      iex> delete_license(license)
      {:error, %Ecto.Changeset{}}

  """
  def delete_license(%License{} = license) do
    Repo.delete(license)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking license changes.

  ## Examples

      iex> change_license(license)
      %Ecto.Changeset{source: %License{}}

  """
  def change_license(%License{} = license) do
    License.changeset(license, %{})
  end
end
