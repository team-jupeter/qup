defmodule Demo.Repo.Migrations.CreateSupuls do
  use Ecto.Migration

  def change do
    create table(:supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :supul_code, :decimal, precision: 8
      add :name, :string
      add :geographical_area, :string

      add :nation_id, references(:nations, type: :uuid, null: false)

      timestamps()
    end
  end
end
