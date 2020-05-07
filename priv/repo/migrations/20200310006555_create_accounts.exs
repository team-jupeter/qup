defmodule Demo.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string
      add :balance, :decimal
      add :locked, :boolean, default: false

      add :supul_id, references(:supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
