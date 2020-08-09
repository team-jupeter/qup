defmodule Demo.Reports.BalanceSheet do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Demo.Reports.BalanceSheet

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "balance_sheets" do
    field :entity_name, :string 
    field :accounts_payable, :decimal, precision: 12, scale: 2, default: 0.0
    field :accounts_receivable, :decimal, precision: 12, scale: 2, default: 0.0
    field :accrued_liabilities, :decimal, precision: 12, scale: 2, default: 0.0
    field :additional_paid_in_capital, :decimal, precision: 12, scale: 2, default: 0.0
    
    # field :t1, :decimal, precision: 12, scale: 2, default: 0.0
    # field :t2, :decimal, precision: 12, scale: 2, default: 0.0
    # field :t3, :decimal, precision: 12, scale: 2, default: 0.0
    # field :t4, :decimal, precision: 12, scale: 2, default: 0.0
    # field :t5, :decimal, precision: 12, scale: 2, default: 0.0

    field :customer_prepayments, :decimal, precision: 12, scale: 2, default: 0.0
    field :fixed_assets, {:array, :map}, default: []
    field :inventory, {:array, :map}, default: []
    field :long_term_debt, :decimal, precision: 12, scale: 2, default: 0.0
    field :marketable_securities, :decimal, precision: 12, scale: 2, default: 0.0
    field :prepaid_expenses, :decimal, precision: 12, scale: 2, default: 0.0
    field :retained_earnings, :decimal, precision: 12, scale: 2, default: 0.0
    field :short_term_debt, :decimal, precision: 12, scale: 2, default: 0.0
    field :stock, :decimal, precision: 12, scale: 2, default: 0.0
    field :taxes, :decimal, precision: 12, scale: 2, default: 0.0
    field :treasury_stock, :decimal, precision: 12, scale: 2, default: 0.0
    
    field :t1_balance, :decimal, precision: 12, scale: 2, default: 0.0
    field :t2_balance, :decimal, precision: 12, scale: 2, default: 0.0
    field :t3_balance, :decimal, precision: 12, scale: 2, default: 0.0
    field :t4_balance, :decimal, precision: 12, scale: 2, default: 0.0
    field :t5_balance, :decimal, precision: 12, scale: 2, default: 0.0

    embeds_many :t1s, Demo.ABC.T1, on_replace: :delete
    embeds_many :t2s, Demo.ABC.T2, on_replace: :delete
    # embeds_many :t3s, Demo.ABC.T3, on_replace: :delete
    embeds_many :t4s, Demo.ABC.T4, on_replace: :delete
    # embeds_many :t5s, Demo.ABC.T5, on_replace: :delete
 
    belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id
    belongs_to :group, Demo.Groups.Group, type: :binary_id
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id

    # has_many :t1s, Demo.T1s.T1, on_replace: :delete
    # has_many :t2s, Demo.T2s.T2, on_replace: :delete
    has_many :t3s, Demo.T3s.T3, on_replace: :delete
    # has_many :t4s, Demo.T4s.T4, on_replace: :delete
    # has_many :t5s, Demo.T5s.T5, on_replace: :delete

    timestamps()
  end

  @fields [
    :accounts_payable,
    :accounts_receivable,
    :accrued_liabilities,
    :additional_paid_in_capital,

    :t1_balance,
    :t2_balance,
    :t3_balance,
    :t4_balance,
    :t5_balance,

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
    :t1_balance,
  ]
  @doc false
  def changeset(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
  end 
  
  def changeset_ts(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
    |> cast_embed(:ts, attrs.t1)
  end 
  

  def changeset_minus_t1_balance(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
    |> put_change(:t1_balance, Decimal.sub(balance_sheet.t1_balance, attrs.amount)) 
  end
  
  def changeset_plus_t1_balance(balance_sheet, attrs \\ %{}) do
    balance_sheet
    |> cast(attrs, @fields)
    |> put_change(:t1_balance, Decimal.add(balance_sheet.t1_balance, attrs.amount)) 
  end
end
