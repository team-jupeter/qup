defmodule Demo.Repo.Migrations.CreateUnitSupuls do
  use Ecto.Migration

  def change do
    create table(:unit_supuls) do
      add :name, :string
      add :nationality, :string
      add :geographical_area, :string

      add :state_supul_id, references(:state_supuls, on_delete: :nothing)
      add :national_supul_id, references(:national_supuls, on_delete: :nothing)

      timestamps()
    end

    create index(:unit_supuls, [:state_supul_id])
  end
end
