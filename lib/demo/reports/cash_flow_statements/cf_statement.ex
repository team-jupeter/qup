defmodule Demo.Reports.CFStatement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "cf_statements" do
    field :capital_expenditures, :decimal, precision: 12, scale: 2
    field :changes_in_working_capital, :decimal, precision: 12, scale: 2
    field :debt_issuance, :decimal, precision: 12, scale: 2
    field :depreciation_amortization, :decimal, precision: 12, scale: 2
    field :equity_issuance, :decimal, precision: 12, scale: 2
    field :net_earnings, :decimal, precision: 12, scale: 2
    field :opening_cash_balance, :decimal, precision: 12, scale: 2

    belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id
    belongs_to :entity, Demo.Business.Entity, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(cash_flow, attrs) do
    cash_flow
    |> cast(attrs, [:net_earnings, :depreciation_amortization, :changes_in_working_capital, :capital_expenditures, :debt_issuance, :equity_issuance, :opening_cash_balance])
    |> validate_required([:net_earnings, :depreciation_amortization, :changes_in_working_capital, :capital_expenditures, :debt_issuance, :equity_issuance, :opening_cash_balance])
  end
end
