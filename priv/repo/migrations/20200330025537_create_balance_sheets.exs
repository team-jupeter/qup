defmodule Demo.Repo.Migrations.CreateBalanceSheets do
  use Ecto.Migration

  def change do
    create table(:balance_sheets, primary_key: false) do
      add :id, :uuid, primary_key: true
      
      add :gab_account_t1, :decimal, precision: 12, scale: 2, default: 0.0
      add :gab_account_t2, :decimal, precision: 12, scale: 2, default: 0.0
      add :gab_account_t3, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :cash, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :marketable_securities, :decimal, precision: 12, scale: 2, default: 0.0
      add :prepaid_expenses, :decimal, precision: 12, scale: 2, default: 0.0
      add :accounts_receivable, :decimal, precision: 12, scale: 2, default: 0.0
      add :inventory, :decimal, precision: 12, scale: 2, default: 0.0
      add :fixed_assets, :decimal, precision: 12, scale: 2, default: 0.0
      add :accounts_payable, :decimal, precision: 12, scale: 2, default: 0.0
      add :accrued_liabilities, :decimal, precision: 12, scale: 2, default: 0.0
      add :customer_prepayments, :decimal, precision: 12, scale: 2, default: 0.0
      add :taxes, :decimal, precision: 12, scale: 2, default: 0.0
      add :short_term_debt, :decimal, precision: 12, scale: 2, default: 0.0
      add :long_term_debt, :decimal, precision: 12, scale: 2, default: 0.0
      add :stock, :decimal, precision: 12, scale: 2, default: 0.0
      add :additional_paid_in_capital, :decimal, precision: 12, scale: 2, default: 0.0
      add :retained_earnings, :decimal, precision: 12, scale: 2, default: 0.0
      add :treasury_stock, :decimal, precision: 12, scale: 2, default: 0.0

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
