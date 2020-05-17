defmodule Demo.Repo.Migrations.CreateInvoiceItems do
  use Ecto.Migration

  def change do
    create table(:invoice_items) do
      add :quantity, :decimal, precision: 12, scale: 2, default: 0.0
      add :price, :decimal, precision: 12, scale: 2, default: 0.0
      add :tax_per_unit, :decimal, precision: 5, scale: 2, default: 0.0
      add :tax_subtotal, :decimal, precision: 5, scale: 2, default: 0.0
      add :subtotal, :decimal, precision: 12, scale: 2, default: 0.0
      add :invoice_id, references(:invoices, type: :uuid, null: false)
      add :item_id, references(:items, type: :uuid, null: false)

      timestamps()
    end

    create index(:invoice_items, [:invoice_id])
    create index(:invoice_items, [:item_id])
  end
end
