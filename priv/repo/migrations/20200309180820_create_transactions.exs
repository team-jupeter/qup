defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :hash_of_invoice, :string

      add :buyer_name, :string  
      add :buyer_id, :binary_id
      add :erl_supul_name, :string
      add :erl_supul_id, :binary_id
      add :seller_name, :string  
      add :seller_id, :binary_id
      add :ssu_supul_name, :string
      add :ssu_supul_id, :binary_id

      add :gps, {:array, :map}
      add :tax, :decimal, default: 0.0
      add :gopang_fee, :decimal, default: 0.0
      add :insurance, :string
      add :abc_input_id, :string 
      add :abc_input_name, :string 
      add :abc_output_id, :string 
      add :abc_output_name, :string 
      add :abc_input_t1s, {:array, :map}, default: []
      add :abc_amount, :decimal, precision: 15, scale: 4
      add :items, {:array, :binary_id}
      add :fiat_currency, :decimal, precision: 15, scale: 4
      add :transaction_status, :string, default: "processing" 
      add :if_only_item, :string
      add :fair?, :boolean, default: false
      add :supul_code, :integer
      add :locked?, :boolean, default: false
      add :archived?, :boolean, default: false
      add :payload, :text
      add :payload_hash, :text
      add :event_hash, :text
      
      add :invoice_id, references(:invoices, type: :uuid, null: false)

      # add :locked, :boolean, default: false
      # add :locking_use_area, {:array, :string}, default: []
      # add :locking_use_until, :naive_datetime
      # add :locking_output_entity_catetory, {:array, :string}, default: []
      # add :locking_output_specific_entities, {:array, :string}, default: []
          
    
      timestamps()
    end
  end
end
