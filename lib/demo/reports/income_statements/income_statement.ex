defmodule Demo.Reports.IncomeStatement do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "income_statements" do
    field :compensation, :decimal, precision: 12, scale: 2, default: 0.0
    field :cost_of_goods_sold, :decimal, precision: 12, scale: 2
    field :depreciation_and_amortization, :decimal, precision: 12, scale: 2
    field :employee_benefits, :decimal, precision: 12, scale: 2
    field :entity_name, :string
    field :expense, :decimal, precision: 12, scale: 2 
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
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id

    timestamps()
  end

  @fields [
    :compensation, 
    :cost_of_goods_sold, 
    :depreciation_and_amortization, 
    :employee_benefits, 
    :income_taxes, 
    :insurance,  
    :marketing, 
    :office, 
    :payroll, 
    :professional_fees, 
    :rent, 
    :repair_and_maintenance, 
    :revenue, 
    :sales_discounts, 
    :supplies, 
    :taxes, 
    :travel_and_entertainment, 
    :utilities, 
    :entity_id, 
    :expense,
  ]
  @doc false
  def changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def private_changeset(income_statement, attrs) do
    changeset(income_statement, attrs)
    |> put_assoc(:entity, attrs.entity)
    |> put_assoc(:supul, attrs.supul)
  end
  @doc false
  def public_changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:entity, attrs.entity)
    |> put_assoc(:nation_supul, attrs.nation_supul)
  end
  
  def tax_changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:taxation, attrs.taxation)
  end
  
  def supul_changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:supul, attrs.supul)
  end
  
  def state_supul_changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:state_supul, attrs.state_supul)
  end
  
  def nation_supul_changeset(income_statement, attrs) do
    income_statement
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:nation_supul, attrs.nation_supul)
  end


end
