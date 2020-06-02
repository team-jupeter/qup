defmodule Demo.Repo.Migrations.CreateDiagnoses do
  use Ecto.Migration

  def change do
    create table(:diagnoses, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :collection_date, :date
      add :received_date, :date
      add :reported_date, :date

      add :client, :binary_id
      add :doctor, :binary_id
      add :clinic, :binary_id
      add :test_name, :string
      add :meditations, {:array, :string}

      add(:basic_metabolic_panel, :jsonb)
      add(:metabolic_panels, {:array, :jsonb}, default: [])
      add(:medical_images, {:array, :jsonb}, default: [])
      add(:test_results, {:array, :jsonb}, default: [])

      add :name, :string

      add :health_report_id, references(:health_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
