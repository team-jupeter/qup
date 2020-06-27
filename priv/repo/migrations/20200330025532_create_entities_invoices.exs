defmodule Demo.Repo.Migrations.CreateEntitiesInvoices do
  use Ecto.Migration
  
  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:entities_invoices, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true

      add :entity_id, references(:entities, on_delete: :delete_all, type: :uuid, null: false)
      add :invoice_id, references(:invoices, on_delete: :delete_all, type: :uuid, null: false)

      timestamps()

    end

    create(index(:entities_invoices, [:entity_id]))
    create(index(:entities_invoices, [:invoice_id]))

  end
end
