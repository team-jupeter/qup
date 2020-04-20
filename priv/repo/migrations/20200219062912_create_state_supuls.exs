defmodule Demo.Repo.Migrations.CreateStateSupuls do
  use Ecto.Migration

  def change do
    create table(:state_supuls) do
      add :name, :string
      add :nationality, :string
      add :geographical_area, :string

      add :national_supul_id, references(:national_supuls, on_delete: :nothing)

      timestamps()
    end

    create index(:state_supuls, [:national_supul_id])
  end
end
