defmodule Demo.GabAccounts do
  @moduledoc """
  The GabAccounts context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.GabAccounts.GabAccount

  @doc """
  Returns the list of gab_accounts.

  ## Examples

      iex> list_gab_accounts()
      [%GabAccount{}, ...]

  """
  def list_gab_accounts do
    Repo.all(GabAccount)
  end

  @doc """
  Gets a single gab_account.

  Raises `Ecto.NoResultsError` if the Gab account does not exist.

  ## Examples

      iex> get_gab_account!(123)
      %GabAccount{}

      iex> get_gab_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gab_account!(id), do: Repo.get!(GabAccount, id)

  @doc """
  Creates a gab_account.

  ## Examples

      iex> create_gab_account(%{field: value})
      {:ok, %GabAccount{}}

      iex> create_gab_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gab_account(attrs \\ %{}) do
    %GabAccount{}
    |> GabAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gab_account.

  ## Examples

      iex> update_gab_account(gab_account, %{field: new_value})
      {:ok, %GabAccount{}}

      iex> update_gab_account(gab_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gab_account(%GabAccount{} = gab_account, attrs) do
    gab_account
    |> GabAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gab_account.

  ## Examples

      iex> delete_gab_account(gab_account)
      {:ok, %GabAccount{}}

      iex> delete_gab_account(gab_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gab_account(%GabAccount{} = gab_account) do
    Repo.delete(gab_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gab_account changes.

  ## Examples

      iex> change_gab_account(gab_account)
      %Ecto.Changeset{source: %GabAccount{}}

  """
  def change_gab_account(%GabAccount{} = gab_account) do
    GabAccount.changeset(gab_account, %{})
  end
end
