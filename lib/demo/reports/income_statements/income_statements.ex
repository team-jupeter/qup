defmodule Demo.IncomeStatements do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.IncomeStatement
  alias Demo.Business.Entity



  def list_income_statements(id) do
    IncomeStatement
    |> entity_income_statements_query(id)
    |> Repo.all()
  end
  
  def get_income_statement!(id), do: Repo.get!(IncomeStatement, id)

  def get_entity_income_statement!(entity_id) do
    IncomeStatement
    |> entity_income_statements_query(entity_id)
    |> Repo.all
  end

  defp entity_income_statements_query(query, entity_id) do    
    from(i in query, where: i.entity_id == ^entity_id)
  end

 
  def create_income_statement(attrs) do
    %IncomeStatement{}
    |> IncomeStatement.private_changeset(attrs)
    |> Repo.insert()
  end

  def create_income_statement(%Entity{} = entity, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
    |> Repo.insert()
  end
 
  def create_public_income_statement(attrs) do
    %IncomeStatement{}
    |> IncomeStatement.public_changeset(attrs)
    |> Repo.insert()
  end
 
  def create_tax_income_statement(attrs) do
    %IncomeStatement{}
    |> IncomeStatement.tax_changeset(attrs)
    |> Repo.insert()
  end
 
  def create_supul_income_statement(attrs) do
    %IncomeStatement{}
    |> IncomeStatement.supul_changeset(attrs)
    |> Repo.insert()
  end
 
  def create_state_supul_income_statement(attrs) do
    %IncomeStatement{}
    |> IncomeStatement.state_supul_changeset(attrs)
    |> Repo.insert()
  end
 
  def create_nation_supul_income_statement(attrs) do
    %IncomeStatement{}
    |> IncomeStatement.nation_supul_changeset(attrs)
    |> Repo.insert()
  end
 

 

  def update_income_statement(%IncomeStatement{} = income_statement, attrs) do
    income_statement
    |> IncomeStatement.changeset(attrs)
    |> Repo.update()
  end

  def change_income_statement(%IncomeStatement{} = income_statement) do
    IncomeStatement.changeset(income_statement, %{})
  end

  def add_expense(%IncomeStatement{} = income_statement, %{amount: amount}) do
    accrued_expense = Decimal.add(income_statement.expense, amount)
    update_income_statement(income_statement, %{expense: accrued_expense})
  end

  def add_revenue(%IncomeStatement{} = income_statement, %{amount: amount}) do
    accrued_revenue = Decimal.add(income_statement.revenue, amount)
    update_income_statement(income_statement, %{revenue: accrued_revenue})
  end

  
'''
  def delete_income_statement(%IncomeStatement{} = income_statement) do
    Repo.delete(income_statement)
  end
'''
end
