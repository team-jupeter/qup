defmodule Demo.Repo.Migrations.CreateSupuls do
  use Ecto.Migration

  def change do
    create table(:supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :supul_code, :integer
      add :name, :string
      add :geographical_area, :string

      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)

      timestamps()
    end
  end
end
