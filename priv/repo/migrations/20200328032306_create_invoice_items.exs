defmodule Demo.Repo.Migrations.CreateInvoiceItems do
  use Ecto.Migration

  def change do
    create table(:invoice_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gpc_code, :text
      add :price, :decimal, precision: 12, scale: 2
      add :quantity, :decimal, precision: 12, scale: 2
      add :subtotal, :decimal, precision: 12, scale: 2
      add :tax, :decimal, precision: 12, scale: 2

      add :invoice_id, references(:invoices, type: :uuid, null: false)
      add :item_id, references(:items, type: :uuid, null: false)

      timestamps()
    end

    create index(:invoice_items, [:invoice_id])
    create index(:invoice_items, [:item_id])
  end
end
