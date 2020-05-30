defmodule Demo.Repo.Migrations.CreateTicketStorages do
  use Ecto.Migration

  def change do
    create table(:ticket_storages, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :new_payload, :binary
      add :ticket_payload_history, {:array, :binary_id}, default: []


      add :mulet_id, references(:mulets, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
