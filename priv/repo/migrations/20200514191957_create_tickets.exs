defmodule Demo.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :invoice_id, :binary_id
      add :package_size, {:array, :map}
      add :package_weight, :integer
      add :box_type, :string
      add :departure, :string
      add :destination, :string
      add :input, {:array, :map}, default: []
      add :output, {:array, :map}, default: []
      add :transport_type, :string
      add :transport_id, :string
      add :valid_until, :naive_datetime
      add :issued_by, :string
      add :user_id, :string
      add :departure_time, :naive_datetime
      add :arrival_time, :naive_datetime
      add :departing_terminal, :string #? terminal_name
      add :arrival_terminal, :string #? terminal_name
      add :gate, :string
      add :seat, :string
      add :caution, :string
      add :gopang_fee, :decimal, precision: 15, scale: 4
      add :status, :string, default: "ticket accepted"
      add :distance, :decimal, precision: 15, scale: 4

      add :route, :map, default: %{}
      add :road_sections, {:array, :jsonb}, default: []
      add :stations, {:array, :jsonb}, default: []
      add :deliverybox, :jsonb
    
      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)
      add :transaction_id, references(:transactions, type: :uuid, null: false, on_delete: :nothing)
      add :car_id, references(:cars, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

    # create index(:tickets, [:entity_id])
    # create index(:tickets, [:transport])
  end
end
