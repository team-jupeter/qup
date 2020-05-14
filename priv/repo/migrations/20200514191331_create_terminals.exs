defmodule Demo.Repo.Migrations.CreateTerminals do
  use Ecto.Migration

  def change do
    create table(:terminals, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :name, :string
      add :address, :string
      add :tel, :string

      add :nation_id, references(:nations, type: :uuid, null: false, on_delete: :nothing)
      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

    # create index(:terminals, [:nation])
    # create index(:terminals, [:entity])
  end
end
