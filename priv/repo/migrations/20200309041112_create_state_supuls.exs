defmodule Demo.Repo.Migrations.CreateStateSupuls do
  use Ecto.Migration

  def change do
    create table(:state_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :state_supul_code, :string
      add :name, :string
      add :nation_name, :string
  
      add :auth_code, :text 

      add :hash_count, :integer, default: 0

      add :sender, :binary_id
      add :hash_chain, {:array, :text}, default: []
      add :openhash_box, {:array, :text}, default: []
      add :current_hash, :text, default: "state_supul origin"
      add :incoming_hash, :text
      add :nation_openhash_id, :binary_id
      add :previous_hash, :text

      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
