defmodule Demo.Accounts do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Accounts.Account


  def list_accounts do
    Repo.all(Account)
  end


  def get_account!(id), do: Repo.get!(Account, id)


  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end


  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
  end


  def delete_account(%Account{} = account) do
    Repo.delete(account)
  end


  def change_account(%Account{} = account) do
    Account.changeset(account, %{})
  end
end
