defmodule Demo.Repo.Migrations.CreatePayloads do
  use Ecto.Migration

  def change do
    create table(:payloads) do
      add :payload, :text
      add :supul, :binary_id
  
      add :supul_id, references(:supuls, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
