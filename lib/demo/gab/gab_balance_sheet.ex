defmodule Demo.Reports.GabBalanceSheet do
    use Ecto.Schema
    import Ecto.Changeset
  
    @primary_key {:id, :binary_id, autogenerate: true}
    schema "gab_balance_sheets" do
      field :monetary_unit, :string
      
      field :t1s, {:array, :map}
      field :t2s, {:array, :map} 
      field :t3s, {:array, :map} 

      field :cashes, {:array, :map} 
      
  
      belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id
  
  
      timestamps()
    end
  
    @fields [:monetary_unit, :gab_account_t1, :gab_account_t2, :gab_account_t3, :cash]
    @doc false
    def changeset(balance_sheet, attrs) do
      balance_sheet
      |> cast(attrs, @fields)
      # |> validate_required([:cash, :marketable_securities, :prepaid_expenses, :accounts_receivable, :inventory, :fixed_assets, :accounts_payable, :accrued_liabilities, :customer_prepayments, :taxes, :short_term_debt, :long_term_debt, :stock, :additional_paid_in_capital, :retained_earnings, :treasury_stock])
    end
  end
  