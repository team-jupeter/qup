defmodule Demo.Repo.Migrations.CreateInvoiceItems do
  use Ecto.Migration

  def change do
    create table(:invoice_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :price, :decimal, precision: 16, scale: 6, default: 0.0
      add :item_name, :string
      add :quantity, :decimal, precision: 12, scale: 2, default: 0.0
      add :tax_subtotal, :decimal, precision: 16, scale: 6, default: 0.0
      add :subtotal, :decimal, precision: 16, scale: 6, default: 0.0
      
      add :buyer_id, :binary_id
      add :buyer_name, :string
      add :buyer_supul_id, :binary_id
      add :buyer_supul_name, :string
  
      add :seller_id, :binary_id
      add :seller_name, :string
      add :seller_supul_id, :binary_id
      add :seller_supul_name, :string

      add :product_id, references(:products, type: :uuid, null: false)
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :invoice_id, references(:invoices, type: :uuid, null: false)

      timestamps()
    end

    create index(:invoice_items, [:product_id])
  end
end
