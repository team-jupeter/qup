defmodule Demo.Taxations.Taxation do
  use Ecto.Schema
  import Ecto.Changeset

  #? This schema is for Tax Authority of a supul including a nation supul.

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "taxations" do
    field :name, :string
    field :gab_balance, :decimal, default: 0.0

    field :auth_code, :string
    field :unique_digits, :string
    field :tels, {:array, :string}

    has_many :entities, Demo.Entities.Entity
    has_many :tax_rates, Demo.Taxations.TaxRate

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id

    has_one :financial_report, Demo.Reports.FinancialReport, on_replace: :nilify
    has_one :income_statement, Demo.Reports.IncomeStatement, on_replace: :nilify
    has_one :balance_sheet, Demo.Reports.BalanceSheet, on_replace: :nilify
    has_one :cf_statement, Demo.Reports.CFStatement, on_replace: :nilify
    has_one :equity_statement, Demo.Reports.EquityStatement, on_replace: :nilify
  
    timestamps()
  end

  @fields [:name, :gab_balance, :auth_code, :unique_digits, :tels, ]

  def changeset(taxation, attrs = %{auth_code: auth_code}) do
    taxation
    |> cast(attrs, @fields)
    |> put_change(:auth_code, attrs.auth_code) 
  end
  @doc false 
  def changeset(taxation, attrs) do
    taxation
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:nation, attrs.nation)
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
  end
end
