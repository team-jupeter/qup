defmodule Demo.Repo.Migrations.CreateOpenHashes do
  use Ecto.Migration

  def change do
    create table(:openhashes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :event_id, :binary_id
      add :erl_email, :string
      add :ssu_email, :string
      add :event_sender, :string
      add :supul_name, :string
      add :incoming_hash, :text 
      add :previous_hash, :text
      add :current_hash, :text
      add :supul_signature, :text

      add :transaction_id, references(:transactions, type: :uuid)
      add :wedding_id, references(:weddings, type: :uuid)
      add :family_id, references(:families, type: :uuid)


      add :supul_id, references(:supuls, type: :uuid)
      add :state_supul_id, references(:state_supuls, type: :uuid)
      add :nation_supul_id, references(:nation_supuls, type: :uuid)
      add :global_supul_id, references(:global_supuls, type: :uuid)

      timestamps()
    end

  end
end
