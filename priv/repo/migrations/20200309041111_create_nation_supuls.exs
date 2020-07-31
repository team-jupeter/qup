defmodule Demo.Repo.Migrations.CreateNationSupuls do
  use Ecto.Migration

  def change do
    create table(:nation_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gab_balance, :decimal, default: 0.0
      add :type, :string
      add :nation_supul_code, :string
      add :name, :string
      add :nation_name, :string

      add :auth_code, :text

      add :hash_count, :integer, default: 0

      add :hash_chain, {:array, :text}, default: []
      add :openhash_box, {:array, :text}, default: []
      add :current_hash, :text, default: "nation_supul origin"
      add :incoming_hash, :text
      add :previous_hash, :text
      add :global_openhash_id, :binary_id  #? openhash_id from global supul
      add :sender, :binary_id
 
      add :global_supul_id, references(:global_supuls, type: :uuid, null: false)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
