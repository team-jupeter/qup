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
  alias Demo.Entities.Entity


  def list_groups(entity) do
    Repo.preload(entity, :group).group
  end

  def get_entity_group(entity) do
    Repo.preload(entity, :group).group
  end 

  def get_group!(id), do: Repo.get!(Group, id)

'''
g = Repo.preload(sanche_entity, :group).group
s = Repo.preload(g, :supul).supul
'''

  def create_group(attrs \\ %{}) do
    # supul = Repo.preload(entity, :supul).supul
    attrs = make_financial_statements(attrs)
    %Group{} 
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def minus_gab_balance(%Group{} = group, %{amount: amount}) do
    minus_gab_balance = Decimal.sub(group.gab_balance, amount)
    update_group(group, %{gab_balance: minus_gab_balance})
  end

  def plus_gab_balance(%Group{} = group, %{amount: amount}) do
    plus_gab_balance = Decimal.add(group.gab_balance, amount)
    update_group(group, %{gab_balance: plus_gab_balance})
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
