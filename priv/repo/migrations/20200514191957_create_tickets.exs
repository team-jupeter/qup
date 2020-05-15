defmodule Demo.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets, primary_key: false) do
      add :id, :uuid, primary_key: true
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
      add :baggage, :decimal
      add :digital_certificate, :string

      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

    # create index(:tickets, [:entity_id])
    # create index(:tickets, [:transport])
  end
end
