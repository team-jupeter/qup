defmodule Demo.Reports.BalanceSheet do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Demo.Reports.BalanceSheet

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "balance_sheets" do
    field :entity_name, :string 
    field :accounts_payable, :decimal, precision: 12, scale: 2
    field :accounts_receivable, :decimal, precision: 12, scale: 2
    field :accrued_liabilities, :decimal, precision: 12, scale: 2
    field :additional_paid_in_capital, :decimal, precision: 12, scale: 2
    field :cash, :decimal, precision: 12, scale: 2
    field :customer_prepayments, :decimal, precision: 12, scale: 2
    field :fixed_assets, {:array, :map}, default: []
    field :inventory, {:array, :map}, default: []
    field :long_term_debt, :decimal, precision: 12, scale: 2
    field :marketable_securities, :decimal, precision: 12, scale: 2
    field :prepaid_expenses, :decimal, precision: 12, scale: 2
    field :retained_earnings, :decimal, precision: 12, scale: 2
    field :short_term_debt, :decimal, precision: 12, scale: 2
    field :stock, :decimal, precision: 12, scale: 2
    field :taxes, :decimal, precision: 12, scale: 2
    field :treasury_stock, :decimal, precision: 12, scale: 2
    
    field :gab_balance, :decimal, precision: 12, scale: 2

    embeds_many :t1s, Demo.ABC.T1, on_replace: :delete
    embeds_many :t2s, Demo.ABC.T2, on_replace: :delete
    embeds_many :t3s, Demo.ABC.T3, on_replace: :delete
 
    belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id
    belongs_to :entity, Demo.Business.Entity, type: :binary_id


    timestamps()
  end

  @fields [
    :accounts_payable,
    :accounts_receivable,
    :accrued_liabilities,
    :additional_paid_in_capital,
    :cash,
    :customer_prepayments,
    :fixed_assets,
    :inventory, 
    :long_term_debt,
    :marketable_securities,
    :prepaid_expenses,
    :retained_earnings,
    :short_term_debt,
    :stock,
    :taxes,
    :treasury_stock,
    :gab_balance,
  ]
  @doc false
  def changeset(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
  end 
  


  def changeset_minus_gab_balance(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
    |> put_change(:gab_balance, Decimal.sub(balance_sheet.gab_balance, attrs.amount)) 
  end
  
  def changeset_plus_gab_balance(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
    |> put_change(:gab_balance, Decimal.add(balance_sheet.gab_balance, attrs.amount)) 
  end
end
