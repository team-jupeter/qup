defmodule Demo.Repo.Migrations.CreateEntitiesGroups do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:entities_groups, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :group_id, references(:groups, type: :uuid, null: false)


    end


    create(
      unique_index(:entities_groups, [:group_id, :entity_id], name: :group_id_entity_id_unique_index)
    )
  end
end
