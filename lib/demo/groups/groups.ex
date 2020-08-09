defmodule Demo.Groups do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Groups.Group
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  # alias Demo.AccountBooks.AccountBook
  # alias Demo.Entities.Entity
  alias Demo.GabAccounts.GabAccount
  # alias Demo.GabAccounts

  def list_groups(entity) do
    Repo.preload(entity, :group).group
  end

  def get_entity_group(entity) do
    Repo.preload(entity, :group).group
  end 

  def get_group!(id), do: Repo.get!(Group, id)
  def get_group(id), do: Repo.get(Group, id)

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

  def minus_t1_balance(%Group{} = group, %{amount: amount}) do
    minus_t1_balance = Decimal.sub(group.t1_balance, amount)
    update_group(group, %{t1_balance: minus_t1_balance})
  end

  def plus_t1_balance(%Group{} = group, %{amount: amount}) do
    plus_t1_balance = Decimal.add(group.t1_balance, amount)
    update_group(group, %{t1_balance: plus_t1_balance})
  end

  defp make_financial_statements(attrs) do
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}
    ga = %GabAccount{}

    Map.merge(attrs, %{is: is, bs: bs, cf: cf, es: es, fr: fr, ga: ga}) 
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
