defmodule Demo.Repo.Migrations.CreatePayloadArchives do
  use Ecto.Migration

  def change do
    create table(:payload_archives, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :payload, :text
      add :payload_hash, :text
      add :openhash, :string, default: "origin"

      add :supul_id, references(:supuls, type: :uuid, null: false)
      
      timestamps()
    end

  end
end
