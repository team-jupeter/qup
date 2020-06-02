defmodule Demo.Repo.Migrations.CreateMachines do
  use Ecto.Migration

  def change do
    create table(:machines, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :gpc_code, :string
      add :location, {:array, :map}
      add :purpose, :string
      add :made_by, :binary_id
      add :made_where, :string
      add :made_when, :date
  
      add :entity_id, references(:entities, type: :uuid, null: false)

      timestamps()
    end

  end
end
