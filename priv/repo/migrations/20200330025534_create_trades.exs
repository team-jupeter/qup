defmodule Demo.Repo.Migrations.CreateInvoice do
  use Ecto.Migration

  def change do
    create table(:trades, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :seller_entity_name, :string
      add :seller_supul_name, :string
      add :seller_nation_name, :string

      add :seller_taxation_name, :string
      add :tax_amount, :decimal

      add :invoice_id, references(:invoices, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :taxation_id, references(:taxations, type: :uuid, null: false)

      timestamps()
    end

  end
end
