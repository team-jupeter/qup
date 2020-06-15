defmodule Demo.Repo.Migrations.CreateHealthReports do
  use Ecto.Migration

  def change do
    create table(:health_reports, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :weight, :decimal
      add :height, :decimal
      add :face, :decimal
      add :fingerprints, {:array, :map}
      add :infection, :boolean, default: false
      add :iris, :decimal
      add :blood_pressure, :decimal
      add :disease, :decimal
      add :dna, :decimal
      add :blood_type, :decimal
      add :vision, :decimal
      add :liver_test, :decimal
      add :disabled, :decimal
      add :cholesterol, :decimal
      add :case_history, :decimal

      add :user_id, references(:users, type: :uuid, null: false)

      timestamps()
    end

  end
end
