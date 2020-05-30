defmodule Demo.Repo.Migrations.CreateMulets do
  use Ecto.Migration

  def change do
    create table(:mulets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :hash_history, {:array, :string}, default: []
      add :current_hash, :string
      add :incoming_hash, :string
  
      add :supul_id, references(:supuls, type: :uuid, null: false, on_delete: :nothing)
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false, on_delete: :nothing)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false, on_delete: :nothing)
      add :global_supul_id, references(:global_supuls, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
