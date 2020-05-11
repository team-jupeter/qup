defmodule Demo.Repo.Migrations.CreateBalanceSheets do
  use Ecto.Migration

  def change do
    create table(:balance_sheets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gab_account, :decimal, precision: 12, scale: 2
      add :cash, :decimal, precision: 12, scale: 2
      add :marketable_securities, :decimal, precision: 12, scale: 2
      add :prepaid_expenses, :decimal, precision: 12, scale: 2
      add :accounts_receivable, :decimal, precision: 12, scale: 2
      add :inventory, :decimal, precision: 12, scale: 2
      add :fixed_assets, :decimal, precision: 12, scale: 2
      add :accounts_payable, :decimal, precision: 12, scale: 2
      add :accrued_liabilities, :decimal, precision: 12, scale: 2
      add :customer_prepayments, :decimal, precision: 12, scale: 2
      add :taxes, :decimal, precision: 12, scale: 2
      add :short_term_debt, :decimal, precision: 12, scale: 2
      add :long_term_debt, :decimal, precision: 12, scale: 2
      add :stock, :decimal, precision: 12, scale: 2
      add :additional_paid_in_capital, :decimal, precision: 12, scale: 2
      add :retained_earnings, :decimal, precision: 12, scale: 2
      add :treasury_stock, :decimal, precision: 12, scale: 2

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
