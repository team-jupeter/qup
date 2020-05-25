defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      #? previous transaction_id and digital signature of invoice
      add :hash_of_invoice, :string

      #? who pays ABC? which t1s in his/her/its wallet?
      add :abc_input, :string #? public_address of buyer. 
      add :abc_output, :string #? public_address of buyer. 
      add :abc_input_t1s, {:array, :map}, default: []
      add :abc_amount, :decimal, precision: 15, scale: 4
      add :items, {:array, :map}


      # add :locked, :boolean, default: false
      # add :locking_use_area, {:array, :string}, default: []
      # add :locking_use_until, :naive_datetime
      # add :locking_output_entity_catetory, {:array, :string}, default: []
      # add :locking_output_specific_entities, {:array, :string}, default: []
          
    
      timestamps()
    end
  end
end
