defmodule Demo.Reports.IncomeStatement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "income_statements" do
    field :compensation, :decimal, precision: 12, scale: 2
    field :cost_of_goods_sold, :decimal, precision: 12, scale: 2
    field :depreciation_and_amortization, :decimal, precision: 12, scale: 2
    field :employee_benefits, :decimal, precision: 12, scale: 2
    field :income_taxes, :decimal, precision: 12, scale: 2
    field :insurance, :decimal, precision: 12, scale: 2 
    field :marketing, :decimal, precision: 12, scale: 2
    field :office, :decimal, precision: 12, scale: 2
    field :payroll, :decimal, precision: 12, scale: 2
    field :professional_fees, :decimal, precision: 12, scale: 2
    field :rent, :decimal, precision: 12, scale: 2
    field :repair_and_maintenance, :decimal, precision: 12, scale: 2
    field :revenue, :decimal, precision: 12, scale: 2
    field :sales_discounts, :decimal, precision: 12, scale: 2
    field :supplies, :decimal, precision: 12, scale: 2
    field :taxes, :decimal, precision: 12, scale: 2
    field :travel_and_entertainment, :decimal, precision: 12, scale: 2
    field :utilities, :decimal, precision: 12, scale: 2

    embeds_many :t1, Demo.ABC.T1
    embeds_many :t2, Demo.ABC.T2
    embeds_many :t3, Demo.ABC.T3

    belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id
    belongs_to :entity, Demo.Accounts.Entity, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, [:revenue, :sales_discounts, :cost_of_goods_sold, :compensation, :depreciation_and_amortization, :employee_benefits, :insurance, :marketing, :office, :supplies, :payroll, :professional_fees, :rent, :repair_and_maintenance, :taxes, :travel_and_entertainment, :utilities, :income_taxes])
    |> validate_required([:revenue, :sales_discounts, :cost_of_goods_sold, :compensation, :depreciation_and_amortization, :employee_benefits, :insurance, :marketing, :office, :supplies, :payroll, :professional_fees, :rent, :repair_and_maintenance, :taxes, :travel_and_entertainment, :utilities, :income_taxes])
  end
end
