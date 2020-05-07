defmodule Demo.Repo.Migrations.CreateSils do
  use Ecto.Migration

  def change do
    create table(:sils, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :entity_id, references(:entities, type: :uuid, null: false)
      timestamps()
    end

  end
end
