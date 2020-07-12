defmodule Demo.Repo.Migrations.CreateGlobalSupuls do
  use Ecto.Migration

  def change do
    create table(:global_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :name, :string

      add :global_signature, :string
      add :hash_count, :integer, default: 0
      add :hash_history, {:array, :string}, default: []
      add :current_hash, :string
      add :incoming_hash, :string
      timestamps()
    end

  end
end
