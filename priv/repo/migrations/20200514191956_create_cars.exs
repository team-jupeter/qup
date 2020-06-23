defmodule Demo.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :category, :string
      add :name, :string
      add :gpc_code, :string
      add :manufacturer, :string
      add :production_date, :naive_datetime
      add :waste_date, :naive_datetime
      add :current_location, :string 
      add :location_history, {:array, :string}
      add :status, {:array, :string}, default: ["normal"]
      add :moving, :boolean, default: false
      add :front_car, :string
      add :destination, :string
      add :current_cargo_type, :string
      add :current_cargo_amount, :string
      add :book_value, :decimal, precision: 15, scale: 4
      add :market_value, :decimal, precision: 15, scale: 4

      add :input, :string
      add :output, :string


      add :current_owner, :binary_id
      add :new_owner, :binary_id
      add :owner_history, {:array, :binary_id}, default: []
      add :current_legal_status, {:array, :string}, default: []
      add :transaction_history, {:array, :binary_id}, default: []
      add :recent_transaction_id, :binary_id

      timestamps()
    end

  end
end
