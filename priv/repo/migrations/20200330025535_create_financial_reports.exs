defmodule Demo.Repo.Migrations.CreateFinancialReports do
  use Ecto.Migration

  def change do
    create table(:financial_reports, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :entity_name, :string
      add :locked, :boolean, default: false
      add :current_hash, :string
      add :openhash_box, {:array, :string}


      #? Summary
      add :credit_rate, :integer
      add :num_of_shares, :integer
      add :num_of_shares_issued, :integer
      add :num_of_treasury_stocks, :integer
      add :market_capitalization, :decimal, precision: 20, scale: 2 
      add :stock_price, :decimal, precision: 10, scale: 2 
      add :intrinsic_value, :decimal, precision: 10, scale: 2 
      add :re_fmv, :decimal, precision: 10, scale: 2 
      add :debt_int_rate, :decimal, precision: 5, scale: 2 

      #? Revenue Analysis
      add :revenue_growth, :decimal, precision: 5, scale: 2 #? (revenue this period - revenue last period) ÷ revenue last period
      add :revenue_concentration, :decimal, precision: 5, scale: 2 #? revenue from client ÷ total revenue)
      add :revenue_per_employee, :decimal, precision: 5, scale: 2  #?(revenues - cost of goods sold) ÷ revenues(revenue ÷ average number of employees)

      add :gross_profit_margin, :decimal, precision: 5, scale: 2 #?(revenues - cost of goods sold) ÷ revenues
      add :operating_profit_margin, :decimal, precision: 5, scale: 2 #?(revenues - cost of goods sold - operating expenses) ÷ revenues
      add :net_profit_margin, :decimal, precision: 5, scale: 2 #? (revenues - cost of goods sold - operating expenses - all other expenses) ÷ revenues															
    
      #? Operational Efficiency
      add :accounts_receivables_turnover, :decimal, precision: 5, scale: 2 #? (net credit sales ÷ average accounts receivable)
      add :inventory_turnover, :decimal, precision: 5, scale: 2 #? (cost of goods sold ÷ average inventory)															
    
      #? Capital Efficiency and Solvency
      add :return_on_equity, :decimal, precision: 5, scale: 2 #? (net income ÷ shareholder’s equity)
      add :debt_to_equity, :decimal, precision: 5, scale: 2 #? (debt ÷ equity)															
    
      #? Liquidity
      add :current_ratio, :decimal, precision: 5, scale: 2 #? (current assets ÷ current liabilities)
      add :interest_coverage, :decimal, precision: 5, scale: 2 #? (earnings before interest and taxes ÷ interest expense)															

      add(:fr_embed_a, :jsonb)
      add(:fr_embed_b, :jsonb)

      add :entity_id, references(:entities, type: :uuid, null: false)
      add :family_id, references(:families, type: :uuid, null: false)
      add :group_id, references(:groups, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :taxation_id, references(:taxations, type: :uuid, null: false)
      add :state_supul_id, references(:state_supuls, type: :uuid, null: false)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)
      add :global_supul_id, references(:global_supuls, type: :uuid, null: false)
      

      timestamps()
    end

  end
end
