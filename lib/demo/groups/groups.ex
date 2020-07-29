defmodule Demo.Groups do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Groups.Group
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  alias Demo.AccountBooks.AccountBook
  # alias Demo.FinancialReports
  # alias Demo.BalanceSheets
  # alias Demo.IncomeStatements
  # alias Demo.CFStatements
  # alias Demo.EquityStatements
  # alias Demo.AccountBooks

  def list_groups(entity) do
    Repo.preload(entity, :group).group
  end

  def get_entity_group(entity) do
    Repo.preload(entity, :group).group
  end 

  def get_group!(id), do: Repo.get!(Group, id)


  def create_group(attrs \\ %{}) do
    attrs = make_financial_statements(attrs)

    %Group{} 
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  defp make_financial_statements(attrs) do
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}

    attrs = Map.merge(attrs, %{is: is, bs: bs, cf: cf, es: es, fr: fr})
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end
end
