defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :hash_of_invoice, :string
      add :buyer, :binary_id  
      add :seller, :binary_id  
      add :abc_input, :string 
      add :abc_output, :string 
      add :abc_input_t1s, {:array, :map}, default: []
      add :abc_amount, :decimal, precision: 15, scale: 4
      add :items, {:array, :map}
      add :fiat_currency, :decimal, precision: 15, scale: 4
      add :txn_status, :string, default: "processing" 
      add :if_only_item, :string
      add :fair?, :boolean, default: false

      # add :locked, :boolean, default: false
      # add :locking_use_area, {:array, :string}, default: []
      # add :locking_use_until, :naive_datetime
      # add :locking_output_entity_catetory, {:array, :string}, default: []
      # add :locking_output_specific_entities, {:array, :string}, default: []
          
    
      timestamps()
    end
  end
end
