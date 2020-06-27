defmodule Demo.Repo.Migrations.CreateInvoiceItems do
  use Ecto.Migration

  def change do
    create table(:invoice_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :price, :decimal, precision: 12, scale: 2, default: 0.0
      add :item_name, :string
      add :quantity, :decimal, precision: 12, scale: 2, default: 0.0
      add :tax_subtotal, :decimal, precision: 5, scale: 2, default: 0.0
      add :subtotal, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :product_id, references(:products, type: :uuid, null: false)
      add :invoice_id, references(:invoices, type: :uuid, null: false)

      timestamps()
    end

    create index(:invoice_items, [:product_id])
  end
end
