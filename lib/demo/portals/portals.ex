defmodule Demo.Portals do
  @moduledoc """
  The Portals context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Portals.Portal

  @doc """
  Returns the list of portals.

  ## Examples

      iex> list_portals()
      [%Portal{}, ...]

  """
  def list_portals do
    Repo.all(Portal)
  end

  @doc """
  Gets a single portal.

  Raises `Ecto.NoResultsError` if the Portal does not exist.

  ## Examples

      iex> get_portal!(123)
      %Portal{}

      iex> get_portal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_portal!(id), do: Repo.get!(Portal, id)

  @doc """
  Creates a portal.

  ## Examples

      iex> create_portal(%{field: value})
      {:ok, %Portal{}}

      iex> create_portal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_portal(attrs \\ %{}) do
    %Portal{}
    |> Portal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a portal.

  ## Examples

      iex> update_portal(portal, %{field: new_value})
      {:ok, %Portal{}}

      iex> update_portal(portal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_portal(%Portal{} = portal, attrs) do
    portal
    |> Portal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a portal.

  ## Examples

      iex> delete_portal(portal)
      {:ok, %Portal{}}

      iex> delete_portal(portal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_portal(%Portal{} = portal) do
    Repo.delete(portal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking portal changes.

  ## Examples

      iex> change_portal(portal)
      %Ecto.Changeset{source: %Portal{}}

  """
  def change_portal(%Portal{} = portal) do
    Portal.changeset(portal, %{})
  end
end
