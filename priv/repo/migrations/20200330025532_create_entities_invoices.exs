defmodule Demo.Repo.Migrations.CreateEntitiesInvoices do
  use Ecto.Migration

  def change do
    create table(:entities_invoices, primary_key: false) do
      add :entity_id, references(:entities, on_delete: :delete_all, type: :uuid, null: false)
      add :invoice_id, references(:invoices, on_delete: :delete_all, type: :uuid, null: false)

      timestamps()

    end

    create(index(:entities_invoices, [:entity_id]))
    create(index(:entities_invoices, [:invoice_id]))

  end
end
