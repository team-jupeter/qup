defmodule Demo.Reports.FREmbedA do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        
        #? Revenue Analysis
        field :revenue_growth, :decimal, precision: 5, scale: 2 #? (revenue this period - revenue last period) ÷ revenue last period
        field :revenue_concentration, :decimal, precision: 5, scale: 2 #? revenue from client ÷ total revenue)
        field :revenue_per_employee, :decimal, precision: 5, scale: 2  #?(revenues - cost of goods sold) ÷ revenues(revenue ÷ average number of employees)

        field :gross_profit_margin, :decimal, precision: 5, scale: 2 #?(revenues - cost of goods sold) ÷ revenues
        field :operating_profit_margin, :decimal, precision: 5, scale: 2 #?(revenues - cost of goods sold - operating expenses) ÷ revenues
        field :net_profit_margin, :decimal, precision: 5, scale: 2 #? (revenues - cost of goods sold - operating expenses - all other expenses) ÷ revenues															
      
        #? Operational Efficiency
        field :accounts_receivables_turnover, :decimal, precision: 5, scale: 2 #? (net credit sales ÷ average accounts receivable)
        field :inventory_turnover, :decimal, precision: 5, scale: 2 #? (cost of goods sold ÷ average inventory)															
      
        #? Capital Efficiency and Solvency
        field :return_on_equity, :decimal, precision: 5, scale: 2 #? (net income ÷ shareholder’s equity)
        field :debt_to_equity, :decimal, precision: 5, scale: 2 #? (debt ÷ equity)															
      
        #? Liquidity
        field :current_ratio, :decimal, precision: 5, scale: 2 #? (current assets ÷ current liabilities)
        field :interest_coverage, :decimal, precision: 5, scale: 2 #? (earnings before interest and taxes ÷ interest expense)															


        timestamps()
    end
  
    @fields [
        :locked,
        :current_hash,
        :openhash_box,
        
        :num_of_shares,
        :market_capitalization,
        :stock_price,
        :intrinsic_value,
        :debt_int_rate,
        
        :revenue_growth,
        :revenue_concentration,
        :revenue_per_employee,
        :gross_profit_margin,
        :operating_profit_margin,
        :net_profit_margin,
        :accounts_receivables_turnover,
        :inventory_turnover,
        :return_on_equity,
        :debt_to_equity,
        :current_ratio,
        :interest_coverage,
    ]
    @doc false
    def changeset(fr_embed, attrs \\ %{}) do
      fr_embed
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
