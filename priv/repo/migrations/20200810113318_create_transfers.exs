defmodule Demo.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :type, :string
      add :erl_id, :binary_id
      add :erl_name, :string 
      add :erl_email, :string 
      add :erl_tel, :string 
      add :erl_supul_id, :binary_id 
      add :erl_state_supul_id, :binary_id
      add :erl_nation_supul_id, :binary_id 
      
      add :ssu_id, :binary_id
      add :ssu_name, :string 
      add :ssu_email, :string 
      add :ssu_tel, :string 
      add :ssu_supul_id, :binary_id 
      add :ssu_state_supul_id, :binary_id
      add :ssu_nation_supul_id, :binary_id 

      add :t1_input_email, :string  
      add :t1_input_name, :string 
      add :t1_output_email, :string  
      add :t1_output_name, :string  
      add :t1_input_t1s, {:array, :map}, default: []
      add :t1_amount, :decimal, precision: 15, scale: 4

      add :fair?, :boolean, default: false

      add :erl_currency, :string
      add :ssu_currency, :string

      add :entity_id, references(:entities, type: :uuid)

      timestamps()
    end

  end
end
