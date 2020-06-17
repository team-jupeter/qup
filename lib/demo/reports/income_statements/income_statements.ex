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
    from(f in query, where: f.entity_id == ^entity_id)
  end

 
  def create_income_statement(%Entity{} = entity, attrs \\ %{}) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
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
  
'''
  def delete_income_statement(%IncomeStatement{} = income_statement) do
    Repo.delete(income_statement)
  end
'''
end