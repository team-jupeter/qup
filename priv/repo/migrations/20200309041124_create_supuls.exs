defmodule Demo.Repo.Migrations.CreateSupuls do
  use Ecto.Migration

  def change do
    create table(:supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gab_balance, :decimal, default: 0.0
      add :type, :string
      add :txn_id, :binary_id
      add :supul_code, :string
      add :supul_name, :string
      add :name, :string
      add :state_name, :string
      add :nation_name, :string

      add :geographical_area, :string

      add :auth_code, :text
  
      add :event_sender, :string
      add :hash_count, :integer, default: 0
      add :hash_chain, {:array, :text}, default: []
      add :openhash_box, {:array, :text}, default: []
      add :current_hash, :text, default: "supul origin"
      add :incoming_hash, :text
      add :previous_hash, :text
      add :state_openhash_id, :binary_id, default: "b87dc547-649b-41cb-9e17-d83977753abc" #? openhash_id from state supul
  
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)
      add :event_id, :binary_id
      timestamps()
    end
  end
end
