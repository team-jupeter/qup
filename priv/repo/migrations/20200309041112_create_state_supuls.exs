defmodule Demo.Repo.Migrations.CreateStateSupuls do
  use Ecto.Migration

  def change do
    create table(:state_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
