defmodule Demo.FinancialAccounts do
  @moduledoc """
  The FinancialAccounts context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.FinancialAccounts.FinancialAccount

  @doc """
  Returns the list of financial_accounts.

  ## Examples

      iex> list_financial_accounts()
      [%FinancialAccount{}, ...]

  """
  def list_financial_accounts do
    Repo.all(FinancialAccount)
  end

  @doc """
  Gets a single financial_account.

  Raises `Ecto.NoResultsError` if the Financial account does not exist.

  ## Examples

      iex> get_financial_account!(123)
      %FinancialAccount{}

      iex> get_financial_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_financial_account!(id), do: Repo.get!(FinancialAccount, id)

  @doc """
  Creates a financial_account.

  ## Examples

      iex> create_financial_account(%{field: value})
      {:ok, %FinancialAccount{}}

      iex> create_financial_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_financial_account(attrs \\ %{}) do
    %FinancialAccount{}
    |> FinancialAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a financial_account.

  ## Examples

      iex> update_financial_account(financial_account, %{field: new_value})
      {:ok, %FinancialAccount{}}

      iex> update_financial_account(financial_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_financial_account(%FinancialAccount{} = financial_account, attrs) do
    financial_account
    |> FinancialAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a financial_account.

  ## Examples

      iex> delete_financial_account(financial_account)
      {:ok, %FinancialAccount{}}

      iex> delete_financial_account(financial_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_financial_account(%FinancialAccount{} = financial_account) do
    Repo.delete(financial_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking financial_account changes.

  ## Examples

      iex> change_financial_account(financial_account)
      %Ecto.Changeset{source: %FinancialAccount{}}

  """
  def change_financial_account(%FinancialAccount{} = financial_account) do
    FinancialAccount.changeset(financial_account, %{})
  end
end
