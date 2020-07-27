defmodule Demo.Reports.EquityStatement do
    use Ecto.Schema
    import Ecto.Changeset
  
    alias Demo.Reports.EquityStatement

    @primary_key {:id, :binary_id, autogenerate: true}
    schema "equity_statements" do
      field :entity_name, :string
      field :opening_balance, :decimal, precision: 12, scale: 2, default: 0.0
      field :net_income, :decimal, precision: 12, scale: 2, default: 0.0 
      field :other_income, :decimal, precision: 12, scale: 2, default: 0.0  
      field :issue_of_new_capital, :decimal, precision: 12, scale: 2, default: 0.0 
      field :net_loss, :decimal, precision: 12, scale: 2, default: 0.0 
      field :other_loss, :decimal, precision: 12, scale: 2, default: 0.0 
      field :dividends, :decimal, precision: 12, scale: 2, default: 0.0 
      field :withdrawal_of_capital, :decimal, precision: 12, scale: 2, default: 0.0
 
      belongs_to :financial_report, Demo.Reports.FinancialReport, type: :binary_id
      belongs_to :entity, Demo.Entities.Entity, type: :binary_id
      belongs_to :group, Demo.Groups.Group, type: :binary_id
      belongs_to :family, Demo.Families.Family, type: :binary_id
      belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
      belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
      belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
      belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id
  
  
      timestamps()
    end
  
    @fields [
      :opening_balance,
      :net_income, 
      :other_income, 
      :issue_of_new_capital, 
      :net_loss, 
      :other_loss, 
      :dividends, 
      :withdrawal_of_capital,
    ]
    @doc false
    def changeset(%EquityStatement{} = equity_statement, attrs) do
      equity_statement
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
  