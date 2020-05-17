defmodule Demo.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gpc_code, :string
      add :category, :string
      add :name, :string
      add :price, :decimal, precision: 12, scale: 2, default: 0.0
      add :product_uuid, :string
      # add :tax_rate, :decimal, precision: 5, scale: 2

      timestamps()
    end
  end
end
