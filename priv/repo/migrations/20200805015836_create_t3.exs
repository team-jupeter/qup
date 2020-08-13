defmodule Demo.Repo.Migrations.CreateT3s do
  use Ecto.Migration

  def change do
    create table(:t3s, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :abc, :decimal, precision: 12, scale: 4, default: 0.0

      add :gab_account_id, references(:gab_accounts, type: :uuid)
      add :gab_id, references(:gabs, type: :uuid)
      add :entity_id, references(:entities, type: :uuid)

      timestamps()
    end
 
  end
end
