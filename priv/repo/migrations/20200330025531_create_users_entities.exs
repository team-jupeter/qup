defmodule Demo.Repo.Migrations.CreateUsersEntities do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:users_entities, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :user_id, references(:users, type: :uuid, null: false)

    end

    # create(index(:users_entities, [:entity_id]))
    # create(index(:users_entities, [:user_id]))

    create(
      unique_index(:users_entities, [:user_id, :entity_id], name: :user_id_entity_id_unique_index)
    )
  end
end
