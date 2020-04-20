defmodule Demo.Repo.Migrations.CreateNationalSupuls do
  use Ecto.Migration

  def change do
    create table(:national_supuls) do
      add :name, :string
      add :geographical_area, :string

      add :continental_supul_id, references :continental_supuls

      timestamps()
    end

    create index(:national_supuls, [:continental_supul_id])
  end
end
