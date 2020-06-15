defmodule Demo.IncomeStatements do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.IncomeStatement
  # alias Demo.Reports.Report
  alias Demo.Accounts.Entity



  def get_entity_income_statement!(%Entity{} = entity, id) do
    IncomeStatement
    |> entity_income_statements_query(entity)
    |> Repo.get!(id)
  end

  defp entity_income_statements_query(query, %Entity{id: entity_id}) do
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


  def delete_income_statement(%IncomeStatement{} = income_statement) do
    Repo.delete(income_statement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_income_statement(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_income_statement(%IncomeStatement{} = income_statement) do
    IncomeStatement.changeset(income_statement, %{})
  end
end
