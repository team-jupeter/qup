defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      
      #? previous transaction_id and index_no
      add :input_from, :string
      add :input_t1s, {:array, :map}, default: []

      #? recipient or seller's public key and payment amount
      add :output_to, :string
      add :output_amount, :decimal, precision: 12, scale: 2

      #? locking script and conditions of spending moneny by recipient.
      add :locked, :boolean, default: false
      add :locking_use_area, {:array, :string}, default: []
      add :locking_use_until, :naive_datetime
      add :locking_output_to_entity_catetory, {:array, :string}, default: []
      add :locking_output_to_specific_entities, {:array, :string}, default: []
          
    
      add :ledger_id, references(:ledgers, type: :uuid, null: false)
      
      timestamps()
    end
  end
end