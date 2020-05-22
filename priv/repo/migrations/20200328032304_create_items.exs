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
      add :document, :string
      add :document_hash, :string
      # add :tax_rate, :decimal, precision: 5, scale: 2

      add :input_tx, :string
      add :output_to, :string
      add :output_ratio, :decimal, precision: 12, scale: 2, default: 100.0
  
      add :locking_use_area, {:array, :string}, default: []
      add :locking_use_until, :naive_datetime
      add :locking_output_to_entity_catetory, {:array, :string}, default: []
      add :locking_output_to_specific_entities, {:array, :string}, default: []
  
      timestamps()
    end
  end
end
