defmodule Demo.Reports.FinancialReport do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Reports.FinancialReport
  alias Demo.Entities.Entity

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "financial_reports" do
    field :entity_name, :string
    field :locked, :boolean, default: false
    field :current_hash, :string
    field :openhash_box, {:array, :string}

    #? Summary
    field :credit_rate, :integer #? 신용 등급 
    field :num_of_shares, :integer
    field :num_of_shares_issued, :integer
    field :num_of_treasury_stocks, :integer
    field :market_capitalization, :decimal, precision: 20, scale: 2 
    field :stock_price, :decimal, precision: 10, scale: 2 
    field :intrinsic_value, :decimal, precision: 10, scale: 2 #? derived from financial statements
    field :re_fmv, :decimal, precision: 10, scale: 2 
    field :debt_int_rate, :decimal, precision: 5, scale: 2 

    # embeds_one :fr_embed_a, Demo.Reports.FREmbedA #? 중소기업
    # embeds_one :fr_embed_b, Demo.Reports.FREmbedB #? 대기업 또는 기업 집단


    has_one :balance_sheet, Demo.Reports.BalanceSheet
    # has_one :t1_balance_sheet, Demo.Reports.GabBalanceSheet
    # has_one :gov_balance_sheet, Demo.Reports.GovBalanceSheet
    # has_one :supul_balance_sheet, Demo.Reports.SupulBalanceSheet
    has_one :income_statement, Demo.Reports.IncomeStatement
    has_one :cf_statement, Demo.Reports.CFStatement
    # has_one :equity_statement,
    # has_one :comprehensive_IS
    # has_one :consolidated_FS

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :group, Demo.Groups.Group, type: :binary_id
    belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Demo.GlobalSupuls.GlobalSupul, type: :binary_id
    
    timestamps()
  end

  @fields [
    :locked, :current_hash, :openhash_box, 
    :num_of_shares, :num_of_shares_issued, :num_of_treasury_stocks, 
    :credit_rate, :market_capitalization, :stock_price, 
    :intrinsic_value, :debt_int_rate, :re_fmv,
    :entity_id, :supul_id, 
  ]

  
  def changeset(financial_report, attrs) do
    financial_report
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def changeset(attrs) do
    %FinancialReport{}
    |> cast(attrs, @fields)
    |> validate_required([])
  end

end
