defmodule Demo.Reports.FinancialReport do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "financial_reports" do
    field :locked, :boolean, default: false

    has_one :balance_sheet, Demo.Reports.BalanceSheet
    has_one :income_statement, Demo.Reports.IncomeStatement
    has_one :cash_flow, Demo.Reports.CashFlow
    # has_one :equity_statement,
    # has_one :comprehensive_IS
    # has_one :consolidated_FS



    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [])
    |> validate_required([])
  end
end
