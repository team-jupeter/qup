defmodule Demo.Repo.Migrations.CreateTreatments do
  use Ecto.Migration

  def change do
    create table(:treatments, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :clinic_id, :string
      add :doctor, :string
      add :nurse, :string

      add :disease, :string
      add :comment, :string

      add :prescription_id, references(:prescriptions, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
