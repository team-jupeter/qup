defmodule Demo.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :uuid, primary_key: true
      
      add :start_at, :naive_datetime
      add :end_at, :naive_datetime
      add :total, :decimal, precision: 12, scale: 2, default: 0.0
      add :tax_total, :decimal, precision: 5, scale: 2, default: 0.0
      add :fiat_currency, :decimal, precision: 12, scale: 2

      add :transaction_id, references(:transactions, type: :uuid, null: false)

      #? embedded
      add(:seller, :jsonb)
      add(:buyer, :jsonb)

      add(:payments, {:array, :jsonb}, default: [])


      timestamps()
    end
  end
end
