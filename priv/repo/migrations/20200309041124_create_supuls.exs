defmodule Demo.Repo.Migrations.CreateSupuls do
  use Ecto.Migration

  def change do
    create table(:supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :supul_code, :string
      add :name, :string
      add :state_name, :string
      add :nation_name, :string
  
      add :geographical_area, :string

      add :auth_code, :text
      add :payload, :text
      add :payload_hash, :text
  
      add :hash_history, {:array, :text}, default: []
      add :current_hash, :text
      add :incoming_hash, :text
  
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)

      timestamps()
    end
  end
end
