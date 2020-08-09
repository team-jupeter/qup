defmodule Demo.Repo.Migrations.CreateGabAccounts do
  use Ecto.Migration

  def change do
    create table(:gab_accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :entity_name, :string
      add :credit_limit, :decimal, precision: 12, scale: 4, default: 0.0
      add :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0
      add :t2_balance, :decimal, precision: 12, scale: 4, default: 0.0
      add :t3_balance, :decimal, precision: 12, scale: 4, default: 0.0
      add :t4_balance, :decimal, precision: 12, scale: 4, default: 0.0

      add :t1_market_value, :decimal, precision: 12, scale: 4, default: 0.0
      add :t2_market_value, :decimal, precision: 12, scale: 4, default: 0.0
      add :t3_market_value, :decimal, precision: 12, scale: 4, default: 0.0
      add :t4_market_value, :decimal, precision: 12, scale: 4, default: 0.0

      add :return_on_t1, :decimal, precision: 12, scale: 4, default: 0.0
      add :return_on_t2, :decimal, precision: 12, scale: 4, default: 0.0
      add :return_on_t3, :decimal, precision: 12, scale: 4, default: 0.0
      add :return_on_t4, :decimal, precision: 12, scale: 4, default: 0.0
  
      add :unique_digits, :string
      add :default_currency, :string, default: "KRW"

      add(:t1s, {:array, :map}, default: [])
      add(:t2s, {:array, :map}, default: [])
      add(:t4s, {:array, :map}, default: [])
      
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :group_id, references(:groups, type: :uuid, null: false)
      add :family_id, references(:families, type: :uuid, null: false)
      add :taxation_id, references(:taxations, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)


      timestamps()
    end

  end
end
