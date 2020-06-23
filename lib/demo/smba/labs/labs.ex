defmodule Demo.Labs do
  @moduledoc """
  The Labs context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Labs.Lab

  @doc """
  Returns the list of name.

  ## Examples

      iex> list_name()
      [%Lab{}, ...]

  """
  def list_name do
    Repo.all(Lab)
  end

  @doc """
  Gets a single lab.

  Raises `Ecto.NoResultsError` if the Lab does not exist.

  ## Examples

      iex> get_lab!(123)
      %Lab{}

      iex> get_lab!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lab!(id), do: Repo.get!(Lab, id)

  @doc """
  Creates a lab.

  ## Examples

      iex> create_lab(%{field: value})
      {:ok, %Lab{}}

      iex> create_lab(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lab(attrs \\ %{}) do
    %Lab{}
    |> Lab.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lab.

  ## Examples

      iex> update_lab(lab, %{field: new_value})
      {:ok, %Lab{}}

      iex> update_lab(lab, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lab(%Lab{} = lab, attrs) do
    lab
    |> Lab.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a lab.

  ## Examples

      iex> delete_lab(lab)
      {:ok, %Lab{}}

      iex> delete_lab(lab)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lab(%Lab{} = lab) do
    Repo.delete(lab)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lab changes.

  ## Examples

      iex> change_lab(lab)
      %Ecto.Changeset{source: %Lab{}}

  """
  def change_lab(%Lab{} = lab) do
    Lab.changeset(lab, %{})
  end
end
