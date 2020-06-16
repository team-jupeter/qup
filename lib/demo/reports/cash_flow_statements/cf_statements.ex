defmodule Demo.CFStatements do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.CFStatement
  # alias Demo.Reports.Report
  alias Demo.Business.Entity


  def get_cf_statement!(id), do: Repo.get!(CFStatement, id)

  def get_entity_cf_statement!(%Entity{} = entity, id) do
    CFStatement
    |> entity_cf_statements_query(entity)
    |> Repo.get!(id)
  end

  defp entity_cf_statements_query(query, %Entity{id: entity_id}) do
    from(f in query, where: f.entity_id == ^entity_id)
  end


  def create_cf_statement(%Entity{} = entity, attrs \\ %{}) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end


  def update_cf_statement(%CFStatement{} = cf_statement, attrs) do
    cf_statement
    |> CFStatement.changeset(attrs)
    |> Repo.update()
  end


  def delete_cf_statement(%CFStatement{} = cf_statement) do
    Repo.delete(cf_statement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_cf_statement(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_cf_statement(%CFStatement{} = cf_statement) do
    CFStatement.changeset(cf_statement, %{})
  end
end
