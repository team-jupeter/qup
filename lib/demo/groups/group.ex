defmodule Demo.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "groups" do
    field :type, :string
    field :name, :string

    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id

    has_many :entities, Demo.Entities.Entity
    # many_to_many(
    #   :entities,
    #   Entity,
    #   # join_through: Demo.Groups.EntitiesGroups,
    #   join_through: "entities_groups",
    #   on_replace: :delete
    # )

    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :income_statement, Demo.Reports.IncomeStatement
    has_one :balance_sheet, Demo.Reports.BalanceSheet
    has_one :cf_statement, Demo.Reports.CFStatement
    has_one :equity_statement, Demo.Reports.EquityStatement

    timestamps()
  end

  @fields [
    :type,
    :name
  ]
  @doc false
  def changeset(group, attrs = %{entities: entities}) do
    group
    |> cast(attrs, @fields)
    |> put_assoc(:entities, entities)
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
  end

  @doc false
  def changeset(group, attrs) do
    IO.puts("group, changeset")

    group
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
  end
end
