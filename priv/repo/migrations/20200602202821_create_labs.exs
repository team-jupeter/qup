defmodule Demo.Repo.Migrations.CreateLabs do
  use Ecto.Migration

  def change do
    create table(:labs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gpc_code, :string
      add :location, :map
      add :purpose, :string
  
      add :entity_id, references(:entities, type: :uuid, null: false)

      timestamps() 
    end

  end
end
