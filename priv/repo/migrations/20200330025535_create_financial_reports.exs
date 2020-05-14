defmodule Demo.Repo.Migrations.CreateFinancialReports do
  use Ecto.Migration

  def change do
    create table(:financial_reports, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :locked, :boolean, default: false

      add :entity_id, references(:entities, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
