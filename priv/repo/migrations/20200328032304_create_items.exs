defmodule Demo.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gpc_code, :string
      add :category, :string 
      add :name, :string
      add :price, :decimal, precision: 15, scale: 4, default: 0.0
      add :product_uuid, :binary_id
      add :document, :string
      add :document_hash, :string

      # add :tax_rate, :decimal, precision: 15, scale: 4
 
      add :locking_use_area, {:array, :string}, default: []
      add :locking_use_until, :naive_datetime
      add :locking_output_entity_catetory, {:array, :string}, default: []
      add :locking_output_specific_entities, {:array, :string}, default: []
    
      timestamps()
    end
  end
end
