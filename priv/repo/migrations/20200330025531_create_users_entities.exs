defmodule Demo.Repo.Migrations.CreateUsersEntities do
  use Ecto.Migration

  def change do
    create table(:users_entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :user_id, references(:users, type: :uuid, null: false)

      # timestamps()

    end

    # create(index(:user_entities, [:entity_id]))
    # create(index(:user_entities, [:user_id]))

    # create(
    #   unique_index(:users_entities, [:user_id, :entity_id], name: :user_id_entity_id_unique_index)
    # )
  end
end
