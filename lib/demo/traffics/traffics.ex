defmodule Demo.Traffics do
  @moduledoc """
  The Traffics context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Traffics.Traffic

  @doc """
  Returns the list of traffics.

  ## Examples

      iex> list_traffics()
      [%Traffic{}, ...]

  """
  def list_traffics do
    Repo.all(Traffic)
  end

  @doc """
  Gets a single traffic.

  Raises `Ecto.NoResultsError` if the Traffic does not exist.

  ## Examples

      iex> get_traffic!(123)
      %Traffic{}

      iex> get_traffic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_traffic!(id), do: Repo.get!(Traffic, id)

  @doc """
  Creates a traffic.

  ## Examples

      iex> create_traffic(%{field: value})
      {:ok, %Traffic{}}

      iex> create_traffic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_traffic(attrs \\ %{}) do
    %Traffic{}
    |> Traffic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a traffic.

  ## Examples

      iex> update_traffic(traffic, %{field: new_value})
      {:ok, %Traffic{}}

      iex> update_traffic(traffic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_traffic(%Traffic{} = traffic, attrs) do
    traffic
    |> Traffic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a traffic.

  ## Examples

      iex> delete_traffic(traffic)
      {:ok, %Traffic{}}

      iex> delete_traffic(traffic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_traffic(%Traffic{} = traffic) do
    Repo.delete(traffic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking traffic changes.

  ## Examples

      iex> change_traffic(traffic)
      %Ecto.Changeset{source: %Traffic{}}

  """
  def change_traffic(%Traffic{} = traffic) do
    Traffic.changeset(traffic, %{})
  end
end
