defmodule Demo.Repo.Migrations.CreateEntitiesProducts do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:entities_products, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :product_id, references(:products, type: :uuid, null: false)

    end

    create(
      unique_index(:entities_products, [:product_id, :entity_id], name: :product_id_entity_id_unique_index)
    )
  end
end

