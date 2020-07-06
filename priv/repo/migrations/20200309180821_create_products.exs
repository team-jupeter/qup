defmodule Demo.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :type, :string
      add :id, :uuid, primary_key: true
      add :name, :string 
      add :price, :decimal
      add :quantity, :decimal
      add :stars, :decimal
      add :pvr, :decimal
      add :description, :text 
      add :document_hash, :string
      add :owner, {:array, :string}

      add :seller_id, :binary_id
      add :seller_name, :string
      add :seller_supul_id, :binary_id
      add :seller_supul_name, :string
      
      add :arrived_when, :naive_datetime #? when arrived to the entity
      add :stored_at, :string #? unique warehouse or device name
      add :managed_by, :string #? unique user name
      add :expiration_date, :naive_datetime
      add :produced_by, :string #? entity name
      
      add :comments,  {:array, :jsonb}, default: []
      add :product_logs,  {:array, :jsonb}, default: []

      add :biz_category_id, references(:biz_categories, type: :uuid)
      add :gpc_code_id, references(:gpc_codes, type: :uuid)
      add :entity_id, references(:entities, type: :uuid)

      timestamps()
    end

  end
end

