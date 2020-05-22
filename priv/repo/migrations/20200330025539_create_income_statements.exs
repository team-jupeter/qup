defmodule Demo.Repo.Migrations.CreateIncomeStatements do
  use Ecto.Migration

  def change do
    create table(:income_statements, primary_key: false) do
      add :id, :uuid, primary_key: true
      
      add :gab_account_t1, :decimal, precision: 12, scale: 2, default: 0.0
      add :gab_account_t2, :decimal, precision: 12, scale: 2, default: 0.0
      add :gab_account_t3, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :revenue, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :sales_discounts, :decimal, precision: 12, scale: 2, default: 0.0
      add :cost_of_goods_sold, :decimal, precision: 12, scale: 2, default: 0.0
      add :compensation, :decimal, precision: 12, scale: 2, default: 0.0
      add :depreciation_and_amortization, :decimal, precision: 12, scale: 2, default: 0.0
      add :employee_benefits, :decimal, precision: 12, scale: 2, default: 0.0
      add :insurance, :decimal, precision: 12, scale: 2, default: 0.0
      add :marketing, :decimal, precision: 12, scale: 2, default: 0.0
      add :office, :decimal, precision: 12, scale: 2, default: 0.0
      add :supplies, :decimal, precision: 12, scale: 2, default: 0.0
      add :payroll, :decimal, precision: 12, scale: 2, default: 0.0
      add :professional_fees, :decimal, precision: 12, scale: 2, default: 0.0
      add :rent, :decimal, precision: 12, scale: 2, default: 0.0
      add :repair_and_maintenance, :decimal, precision: 12, scale: 2, default: 0.0
      add :taxes, :decimal, precision: 12, scale: 2, default: 0.0
      add :travel_and_entertainment, :decimal, precision: 12, scale: 2, default: 0.0
      add :utilities, :decimal, precision: 12, scale: 2, default: 0.0
      add :income_taxes, :decimal, precision: 12, scale: 2, default: 0.0

      add(:t1, {:array, :jsonb}, default: [])
      add(:t2, {:array, :jsonb}, default: [])
      add(:t3, {:array, :jsonb}, default: [])

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
