defmodule Demo.Repo.Migrations.CreateGabAccounts do
  use Ecto.Migration

  def change do
    create table(:gab_accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :entity_name, :string
      add :credit_limit, :string
      add :gab_balance, :decimal, default: 0.0
      add :unique_digits, :string

      add :t1, :decimal, default: 0.0
      add :t2, :decimal, default: 0.0
      add :t3, :decimal, default: 0.0
      add :t4, :decimal, default: 0.0
      add :t5, :decimal, default: 0.0 

      add :entity_id, references(:entities, type: :uuid, null: false)
      add :group_id, references(:groups, type: :uuid, null: false)
      add :family_id, references(:families, type: :uuid, null: false)
      add :taxation_id, references(:taxations, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)

      add(:ts, {:array, :map}, default: [])

      timestamps()
    end

  end
end
