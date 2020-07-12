defmodule Demo.Repo.Migrations.CreateNationSupuls do
  use Ecto.Migration

  def change do
    create table(:nation_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :type, :string
      add :nation_supul_code, :string
  
      add :auth_code, :text
      add :hash_count, :integer, default: 0
      add :hash_history, {:array, :text}, default: []
      add :current_hash, :text, default: "nation_supul origin"
      add :incoming_hash, :text
  
      add :global_supul_id, references(:global_supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
