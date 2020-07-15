defmodule Demo.Repo.Migrations.CreateGlobalSupuls do
  use Ecto.Migration

  def change do
    create table(:global_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :name, :string

      add :auth_code, :string
      add :global_signature, :text
      add :hash_count, :integer, default: 0
      add :hash_chain, {:array, :text}, default: []
      add :openhash_box, {:array, :text}, default: []
      add :current_hash, :text
      add :incoming_hash, :text
      add :global_openhash_id, :binary_id
      
      timestamps()
    end

  end
end
