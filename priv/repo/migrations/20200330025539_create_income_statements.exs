defmodule Demo.Repo.Migrations.CreateIncomeStatements do
  use Ecto.Migration

  def change do
    create table(:income_statements, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :revenue, :decimal, precision: 12, scale: 2
      add :sales_discounts, :decimal, precision: 12, scale: 2
      add :cost_of_goods_sold, :decimal, precision: 12, scale: 2
      add :compensation, :decimal, precision: 12, scale: 2
      add :depreciation_and_amortization, :decimal, precision: 12, scale: 2
      add :employee_benefits, :decimal, precision: 12, scale: 2
      add :insurance, :decimal, precision: 12, scale: 2
      add :marketing, :decimal, precision: 12, scale: 2
      add :office, :decimal, precision: 12, scale: 2
      add :supplies, :decimal, precision: 12, scale: 2
      add :payroll, :decimal, precision: 12, scale: 2
      add :professional_fees, :decimal, precision: 12, scale: 2
      add :rent, :decimal, precision: 12, scale: 2
      add :repair_and_maintenance, :decimal, precision: 12, scale: 2
      add :taxes, :decimal, precision: 12, scale: 2
      add :travel_and_entertainment, :decimal, precision: 12, scale: 2
      add :utilities, :decimal, precision: 12, scale: 2
      add :income_taxes, :decimal, precision: 12, scale: 2

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
