defmodule Demo.Repo.Migrations.CreateLedgers do
  use Ecto.Migration

  def change do
    create table(:ledgers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :seller_id, :string
      add :buyer_id, :string
      add :amount, :decimal
      add :item, :string
      add :quantity, :decimal, default: 0.0
      # add :invoice_items, {:array, :map}
      add :invoice_id, :string

      timestamps()
    end

  end
end
