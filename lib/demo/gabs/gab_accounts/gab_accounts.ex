defmodule Demo.GabAccounts do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.GabAccounts.GabAccount
  alias Demo.Accounts.Entity


 
  def get_gab_account!(id), do: Repo.get!(GabAccount, id)

  def list_entity_gab_accounts(%Entity{} = entity) do
    GabAccount
    |> entity_gab_accounts_query(entity)
    |> Repo.all()
  end

  defp entity_gab_accounts_query(query, %Entity{id: entity_id}) do
    from(v in query, where: v.entity_id == ^entity_id)
  end

  def get_entity_gab_account!(%Entity{} = entity, id) do
    GabAccount
    |> entity_gab_accounts_query(entity)
    |> Repo.get!(id)
  end

  def create_gab_account(%Entity{} = entity, attrs \\ %{}) do
    %GabAccount{}
    |> GabAccount.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  def update_gab_account(%GabAccount{} = gab_account, attrs) do
    gab_account
    |> GabAccount.changeset(attrs)
    |> Repo.update()
  end


  def delete_gab_account(%GabAccount{} = gab_account) do
    Repo.delete(gab_account)
  end


  def change_gab_account(%GabAccount{} = gab_account) do
    GabAccount.changeset(gab_account, %{})
  end
end
