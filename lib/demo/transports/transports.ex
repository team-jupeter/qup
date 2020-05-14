defmodule Demo.Transports do
  @moduledoc """
  The Transports context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Transports.Transport

  @doc """
  Returns the list of type.

  ## Examples

      iex> list_type()
      [%Transport{}, ...]

  """
  def list_type do
    Repo.all(Transport)
  end

  @doc """
  Gets a single transport.

  Raises `Ecto.NoResultsError` if the Transport does not exist.

  ## Examples

      iex> get_transport!(123)
      %Transport{}

      iex> get_transport!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transport!(id), do: Repo.get!(Transport, id)

  @doc """
  Creates a transport.

  ## Examples

      iex> create_transport(%{field: value})
      {:ok, %Transport{}}

      iex> create_transport(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transport(attrs \\ %{}) do
    %Transport{}
    |> Transport.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transport.

  ## Examples

      iex> update_transport(transport, %{field: new_value})
      {:ok, %Transport{}}

      iex> update_transport(transport, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transport(%Transport{} = transport, attrs) do
    transport
    |> Transport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transport.

  ## Examples

      iex> delete_transport(transport)
      {:ok, %Transport{}}

      iex> delete_transport(transport)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transport(%Transport{} = transport) do
    Repo.delete(transport)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transport changes.

  ## Examples

      iex> change_transport(transport)
      %Ecto.Changeset{source: %Transport{}}

  """
  def change_transport(%Transport{} = transport) do
    Transport.changeset(transport, %{})
  end
end
