defmodule Demo.Repo.Migrations.CreateTrades do
  use Ecto.Migration

  def change do
    create table(:trades) do
      add :dummy_product, :string
      add :dummy_buyer, :string
      add :dummy_seller, :string

      add :unit_supul_id, references(:unit_supuls)

      timestamps()
    end
    # create unique_index :trades, [:product_id]
  end
end
