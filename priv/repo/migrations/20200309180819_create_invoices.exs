defmodule Demo.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :uuid, primary_key: true
      
      add :openhash, :string
      add :start_at, :naive_datetime
      add :end_at, :naive_datetime
      add :total, :decimal, precision: 12, scale: 4, default: 0.0
      add :tax_total, :decimal, precision: 5, scale: 4, default: 0.0
      add :fiat_currency, :decimal, precision: 12, scale: 2

      add :buyer_id, :binary_id
      add :buyer_name, :string
      add :buyer_supul_id, :binary_id
      add :buyer_supul_name, :string
      add :seller_id, :binary_id
      add :seller_name, :string
      add :seller_supul_id, :binary_id
      add :seller_supul_name, :string

      add :entity_id, references(:entities, type: :uuid, null: false)

      #? embedded
      # add(:seller, :jsonb)
      # add(:buyer, :jsonb)

      add(:payments, {:array, :jsonb}, default: [])


      timestamps()
    end
  end
end
