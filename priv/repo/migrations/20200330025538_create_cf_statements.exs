defmodule Demo.Repo.Migrations.CreateCFStatements do
  use Ecto.Migration

  def change do
    create table(:cf_statements, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :entity_name, :string
      add :net_earnings, :decimal, precision: 12, scale: 2, default: 0.0
      add :depreciation_amortization, :decimal, precision: 12, scale: 2, default: 0.0
      add :changes_in_working_capital, :decimal, precision: 12, scale: 2, default: 0.0
      add :capital_expenditures, :decimal, precision: 12, scale: 2, default: 0.0
      add :debt_issuance, :decimal, precision: 12, scale: 2, default: 0.0
      add :equity_issuance, :decimal, precision: 12, scale: 2, default: 0.0
      add :opening_cash_balance, :decimal, precision: 12, scale: 2, default: 0.0

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)
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
