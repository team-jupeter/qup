defmodule Demo.Reports.FREmbedB do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        ''' 
        Leverage Analysis
        Leverage ratios are one of the most common methods analysts use to evaluate company performance. A single financial metric, like total debt, may not be that insightful on its own, so it’s helpful to compare it to a company’s total equity to get a full picture of the capital structure. The result is the debt/equity ratio.
        '''
        field :debt_to_equity, :decimal, precision: 5, scale: 2 #? Debt/equity
        field :debt_to_ebitda, :decimal, precision: 5, scale: 2 #? Debt/EBITDA
        field :ebit_to_int, :decimal, precision: 5, scale: 2 #? EBIT/interest (interest coverage)
        field :dupont_analysis, :decimal, precision: 5, scale: 2 #? Dupont analysis - a combination of ratios, often referred to as the pyramid of ratios, including leverage and liquidity analysis
        
        '''
        Growth Rates
        Analyzing historical growth rates and projecting future ones are a big part of any financial analyst’s job. Common examples of analyzing growth include:
        '''
        field :yoy, {:array, :map} #? Year-over-year (YoY)
        field :regression, {:array, :map} #? Regression analysis
        field :bottom_up, {:array, :map} #? Bottom-up analysis (starting with individual drivers of revenue in the business)
        field :top_down, {:array, :map} #? Top-down analysis (starting with market size and market share)
        
        
        '''
        Profitability Analysis
        Profitability is a type of income statement analysis where an analyst assesses how attractive the economics of a business are. Common examples of profitability measures include:
        '''
        field :gross_margin, :decimal, precision: 5, scale: 2 #? Gross margin
        field :ebitda_margin, :decimal, precision: 5, scale: 2 #? EBITDA margin
        field :ebit_margin, :decimal, precision: 5, scale: 2 #? EBIT margin
        field :net_profit_margin, :decimal, precision: 5, scale: 2 #? Net profit margin
        
        '''
        Liquidity Analysis
        This is a type of financial analysis that focuses on the balance sheet, particularly, a company’s ability to meet short-term obligations (those due in less than a year). Common examples of liquidity analysis include:
        '''
        field :current_ratio, :decimal, precision: 5, scale: 2 #? Current ratio
        field :acid_test, {:array, :map} #? Acid test
        field :cash_ration, :decimal, precision: 5, scale: 2 #? Cash ratio
        field :new_working_capital, :decimal, precision: 5, scale: 2 #? Net working capital
        
        
        '''
        Efficiency Analysis
        Efficiency ratios are an essential part of any robust financial analysis. These ratios look at how well a company manages its assets and uses them to generate revenue and cash flow.
        '''
        field :asset_turnover_ration, :decimal, precision: 5, scale: 2 #? Asset turnover ratio
        field :fixed_asset_turnover_ratio, :decimal, precision: 5, scale: 2 #? Fixed asset turnover ratio
        field :cash_conversion_ratio, :decimal, precision: 5, scale: 2 #? Cash conversion ratio
        field :inventory_turnover_ratio, :decimal, precision: 5, scale: 2 #? Inventory turnover ratio
        
        '''
        Cash Flow
        As they say in finance, cash is king, and, thus, a big emphasis is placed on a company’s ability to generate cash flow. Analysts across a wide range of finance careers spend a great deal of time looking at companies’ cash flow profiles.
        The Statement of Cash Flows is a great place to get started, including looking at each of the three main sections: operating activities, investing activities, and financing activities.
        '''
        field :ocf, :decimal, precision: 5, scale: 2 #? Operating Cash Flow (OCF)
        field :fcf, :decimal, precision: 5, scale: 2 #? Free Cash Flow (FCF)
        field :ficf, :decimal, precision: 5, scale: 2 #? Free Cash Flow to the Firm (FCFF)
        field :fcfe, :decimal, precision: 5, scale: 2 #? Free Cash Flow to Equity (FCFE)
        
        '''
        Rates of Return
        At the end of the day, investors, lenders, and finance professionals, in general, are focused on what type of risk-adjusted rate of return they can earn on their money. As such, assessing rates of return on investment (ROI) is critical in the industry.
        '''
        field :roe, :decimal, precision: 5, scale: 2 #? Return on Equity (ROE)
        field :roa, :decimal, precision: 5, scale: 2 #? Return on Assets (ROA)
        field :roic, :decimal, precision: 5, scale: 2 #? Return on invested capital (ROIC)
        field :dividend_yield, :decimal, precision: 5, scale: 2 #? Dividend Yield
        field :capital_gain, :decimal, precision: 5, scale: 2 #? Capital Gain
        field :arr, :decimal, precision: 5, scale: 2 #? Accounting rate of return (ARR)
        field :irr, :decimal, precision: 5, scale: 2 #? Internal Rate of Return (IRR)
        

        timestamps()
    end
  
    @doc false
    def changeset(fr, attrs) do
      fr
      |> cast(attrs, [])
      |> validate_required([])
    end
  end
