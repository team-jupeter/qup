defmodule Demo.Repo.Migrations.CreateEquityStatements do
  use Ecto.Migration

  def change do
    create table(:equity_statements, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :entity_name, :string
      add :opening_balance, :decimal, precision: 12, scale: 2, default: 0.0
      add :net_income, :decimal, precision: 12, scale: 2, default: 0.0 
      add :other_income, :decimal, precision: 12, scale: 2, default: 0.0 
      add :issue_of_new_capital, :decimal, precision: 12, scale: 2, default: 0.0 
      add :net_loss, :decimal, precision: 12, scale: 2, default: 0.0 
      add :other_loss, :decimal, precision: 12, scale: 2, default: 0.0 
      add :dividends, :decimal, precision: 12, scale: 2, default: 0.0 
      add :withdrawal_of_capital, :decimal, precision: 12, scale: 2, default: 0.0

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)
      add :entity_id, references(:entities, type: :uuid, null: false)


      timestamps()
    end

  end
end
