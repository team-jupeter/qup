defmodule Demo.Phones do
  @moduledoc """
  The Sphones context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Phones.Phone

  @doc """
  Returns the list of sphones.

  ## Examples

      iex> list_sphones()
      [%Sphone{}, ...]

  """
  def list_phones do
    Repo.all(Phone)
  end

  def get_sphone!(id), do: Repo.get!(Phone, id)

  @doc """
  Creates a sphone.

  ## Examples

      iex> create_sphone(%{field: value})
      {:ok, %Sphone{}}

      iex> create_sphone(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sphone(attrs \\ %{}) do
    %Phone{}
    |> Phone.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sphone.

  ## Examples

      iex> update_sphone(sphone, %{field: new_value})
      {:ok, %Sphone{}}

      iex> update_sphone(sphone, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_phone(%Phone{} = phone, attrs) do
    phone
    |> Phone.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sphone.

  ## Examples

      iex> delete_sphone(sphone)
      {:ok, %Sphone{}}

      iex> delete_sphone(sphone)
      {:error, %Ecto.Changeset{}}

  """
  def delete_phone(%Phone{} = phone) do
    Repo.delete(phone)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sphone changes.

  ## Examples

      iex> change_sphone(sphone)
      %Ecto.Changeset{source: %Sphone{}}

  """
  def change_phone(%Phone{} = phone) do
    Phone.changeset(phone, %{})
  end
end
