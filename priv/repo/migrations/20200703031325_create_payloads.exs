defmodule Demo.Repo.Migrations.CreatePayloads do
  use Ecto.Migration

  def change do
    create table(:payloads, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :payload, :string
 
      add :supul_id, references(:supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
