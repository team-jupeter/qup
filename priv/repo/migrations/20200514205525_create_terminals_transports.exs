defmodule Demo.Repo.Migrations.TerminalsTransports do
  use Ecto.Migration

  def change do
    create table(:terminals_transports, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      add :terminal_id, references(:terminals, type: :uuid, null: false)
      add :transport_id, references(:transports, type: :uuid, null: false)
    end
  end
end
