defmodule Demo.Repo.Migrations.CreateSupuls do
  use Ecto.Migration

  def change do
    create table(:supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :nationality, :string
      add :geographical_area, :string

      add :state_supul_id, references(:state_supuls, on_delete: :nothing)
      add :national_supul_id, references(:national_supuls, on_delete: :nothing)

      timestamps()
    end

    create index(:supuls, [:state_supul_id])
  end
end
