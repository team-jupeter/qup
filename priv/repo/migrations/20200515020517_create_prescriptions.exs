defmodule Demo.Repo.Migrations.CreatePrescriptions do
  use Ecto.Migration

  def change do
    create table(:prescriptions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :clinic_id, :string
      add :doctor, :string
      add :dignosis, :string
      add :comment, :string
      add :medicine, :string
      add :test, :string
      add :infection, :boolean

      add :health_report_id, references(:health_reports, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
