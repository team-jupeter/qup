defmodule Demo.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :amount, :decimal, precision: 12, scale: 2
      add :balance, :decimal, precision: 12, scale: 2

      #? embedded fields
      add(:seller, :jsonb)
      add(:buyer, :jsonb)

      timestamps()
    end
  end
end
