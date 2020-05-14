defmodule Demo.Repo.Migrations.CreateType do
  use Ecto.Migration

  def change do
    create table(:transports, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :transport_type, :string
      add :transport_id, :string
      add :capacity, :string
      add :purpose, :string

      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

    # create index(:type, [:entity_id])
  end
end
