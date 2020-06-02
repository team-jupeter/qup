defmodule Demo.Repo.Migrations.CreateMetabolicPanels do
  use Ecto.Migration

  def change do
    create table(:metabolic_panels, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :panel_name, :string
      add :comment, :string
      add :result, :string

      add :metabolic_items, {:array, :jsonb}, default: []
      add :diagnosis_id, references(:diagnoses, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
