defmodule Demo.Repo.Migrations.CreateRealEstates do
  use Ecto.Migration

  def change do
    create table(:real_estates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :category, :string 
      add :address, :string 
      add :gpc_code, :string
  
      add :longitude, :string
      add :latitude, :string
      add :altitude, :string
  
      add :book_value, :decimal, precision: 15, scale: 4
      add :market_value, :decimal, precision: 15, scale: 4
  
      add :current_owner, :binary_id
      add :new_owner, :binary_id
      add :owner_history, {:array, :binary_id}, default: []
      add :current_legal_status, {:array, :string}, default: []
      add :transaction_history, {:array, :binary_id}, default: []
      add :recent_transaction_id, :binary_id
  
      add :input, :string
      add :output, :string
      timestamps()
    end

  end 
end
