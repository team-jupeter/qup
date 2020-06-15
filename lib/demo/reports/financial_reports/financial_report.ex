defmodule Demo.Reports.FinancialReport do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "financial_reports" do
    field :locked, :boolean, default: false
    field :current_hash, :string
    field :hash_history, {:array, :string}

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

    embeds_one :fr_embed_a, Demo.Reports.FREmbedA #? 중소기업
    embeds_one :fr_embed_b, Demo.Reports.FREmbedB #? 대기업 또는 기업 집단


    has_one :balance_sheet, Demo.Reports.BalanceSheet
    has_one :gab_balance_sheet, Demo.Reports.GabBalanceSheet
    has_one :gov_balance_sheet, Demo.Reports.GovBalanceSheet
    has_one :supul_balance_sheet, Demo.Reports.SupulBalanceSheet
    has_one :income_statement, Demo.Reports.IncomeStatement
    has_one :cf_statement, Demo.Reports.CFStatement
    # has_one :equity_statement,
    # has_one :comprehensive_IS
    # has_one :consolidated_FS

    belongs_to :entity, Demo.Accounts.Entity, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.Supuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.Supuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Demo.Supuls.GlobalSupul, type: :binary_id
    
    timestamps()
  end

  @fields [:num_of_treasury_stocks, :locked, :num_of_shares, :hash_history, :market_capitalization, :stock_price, :intrinsic_value, :debt_int_rate]
  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, @fields)
    |> validate_required([])
    # |> cast_embed([:fr_embed_a, :fr_embed_b])
  end
end
