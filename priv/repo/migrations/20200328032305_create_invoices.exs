defmodule Demo.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :start_at, :date
      add :end_at, :date
      add :total, :decimal, precision: 12, scale: 2, default: 0.0
      add :tax_total, :decimal, precision: 5, scale: 2, default: 0.0


      #? embedded
      add(:seller, :jsonb)
      add(:buyer, :jsonb)

      timestamps()
    end
  end
end
