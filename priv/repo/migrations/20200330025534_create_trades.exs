defmodule Demo.Repo.Migrations.CreateInvoice do
  use Ecto.Migration

  def change do
    create table(:trades, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :seller_entity_name, :string
      add :seller_entity_id, :string
      add :seller_supul_name, :string
      add :seller_supul_id, :string
      add :seller_nation_name, :string
      add :seller_nation_id, :string
      add :seller_taxation_name, :string
      add :seller_taxation_id, :string

      add :buyer_entity_name, :string
      add :buyer_entity_id, :string
      add :buyer_supul_name, :string
      add :buyer_supul_id, :string
      add :buyer_nation_name, :string
      add :buyer_nation_id, :string
      add :buyer_taxation_name, :string
      add :buyer_taxation_id, :string

      add :tax_amount, :decimal, precision: 15, scale: 2

      timestamps()
    end

  end
end
