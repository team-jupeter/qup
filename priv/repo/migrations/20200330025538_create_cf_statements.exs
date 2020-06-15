defmodule Demo.Repo.Migrations.CreateCFStatements do
  use Ecto.Migration

  def change do
    create table(:cf_statements, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :net_earnings, :decimal, precision: 12, scale: 2, default: 0.0
      add :depreciation_amortization, :decimal, precision: 12, scale: 2, default: 0.0
      add :changes_in_working_capital, :decimal, precision: 12, scale: 2, default: 0.0
      add :capital_expenditures, :decimal, precision: 12, scale: 2, default: 0.0
      add :debt_issuance, :decimal, precision: 12, scale: 2, default: 0.0
      add :equity_issuance, :decimal, precision: 12, scale: 2, default: 0.0
      add :opening_cash_balance, :decimal, precision: 12, scale: 2, default: 0.0

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)
      add :entity_id, references(:entities, type: :uuid, null: false)

      timestamps()
    end

  end
end
