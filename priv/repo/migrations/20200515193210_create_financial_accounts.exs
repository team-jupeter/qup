defmodule Demo.Repo.Migrations.CreateFinancialAccounts do
  use Ecto.Migration

  def change do
    create table(:financial_accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :left, :string
      add :right, :string
      add :account, :string

      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

    create index(:financial_accounts, [:entity_id])
  end
end
