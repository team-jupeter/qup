defmodule Demo.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :mentors, {:array, :binary_id}
      add :monthly_tution_fee, :decimal, precision: 8, scale: 2
      add :students, {:array, :binary_id}
      
      add(:graduates, {:array, :jsonb}, default: [])

      add :supul_id, references(:supuls, type: :uuid, null: false, on_delete: :nothing)
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false, on_delete: :nothing)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false, on_delete: :nothing)
      add :global_supul_id, references(:global_supuls, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
