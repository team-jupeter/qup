defmodule Demo.Repo.Migrations.CreateGabAccounts do
  use Ecto.Migration

  def change do
    create table(:gab_accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :balance, :decimal
      add :transactions, {:array, :map}

      add :user_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:gab_accounts, [:user_id])
  end
end
