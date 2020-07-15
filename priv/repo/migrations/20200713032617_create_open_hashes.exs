defmodule Demo.Repo.Migrations.CreateOpenHashes do
  use Ecto.Migration

  def change do
    create table(:open_hashes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :txn_id, :binary_id
      add :incoming_hash, :text 
      add :previous_hash, :text
      add :current_hash, :text
      add :supul_signature, :text

      add :transaction_id, references(:transactions, type: :uuid)
      add :supul_id, references(:supuls, type: :uuid)
      add :state_supul_id, references(:state_supuls, type: :uuid)
      add :nation_supul_id, references(:nation_supuls, type: :uuid)
      add :global_supul_id, references(:global_supuls, type: :uuid)

      timestamps()
    end

  end
end
