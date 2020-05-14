defmodule Demo.Reports.BalanceSheet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "balance_sheets" do
    field :gab_account, :decimal, precision: 12, scale: 2
    field :accounts_payable, :decimal, precision: 12, scale: 2
    field :accounts_receivable, :decimal, precision: 12, scale: 2
    field :accrued_liabilities, :decimal, precision: 12, scale: 2
    field :additional_paid_in_capital, :decimal, precision: 12, scale: 2
    field :cash, :decimal, precision: 12, scale: 2
    field :customer_prepayments, :decimal, precision: 12, scale: 2
    field :fixed_assets, :decimal, precision: 12, scale: 2
    field :inventory, :decimal, precision: 12, scale: 2
    field :long_term_debt, :decimal, precision: 12, scale: 2
    field :marketable_securities, :decimal, precision: 12, scale: 2
    field :prepaid_expenses, :decimal, precision: 12, scale: 2
    field :retained_earnings, :decimal, precision: 12, scale: 2
    field :short_term_debt, :decimal, precision: 12, scale: 2
    field :stock, :decimal, precision: 12, scale: 2
    field :taxes, :decimal, precision: 12, scale: 2
    field :treasury_stock, :decimal, precision: 12, scale: 2

    belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id


    timestamps()
  end

  @doc false
  def changeset(balance_sheet, attrs) do
    balance_sheet
    |> cast(attrs, [:gab_account])
    # |> validate_required([:cash, :marketable_securities, :prepaid_expenses, :accounts_receivable, :inventory, :fixed_assets, :accounts_payable, :accrued_liabilities, :customer_prepayments, :taxes, :short_term_debt, :long_term_debt, :stock, :additional_paid_in_capital, :retained_earnings, :treasury_stock])
  end
end
