defmodule Demo.EquityStatements do

    import Ecto.Query, warn: false
    alias Demo.Repo
  
    alias Demo.Reports.EquityStatement
    # alias Demo.Reports.Report
    alias Demo.Business.Entity
  
  
    def get_equity_statement!(id), do: Repo.get!(EquityStatement, id)
  
    def get_entity_equity_statement!(id) do
      EquityStatement
      |> entity_equity_statements_query(id)
      |> Repo.all
    end
  
    defp entity_equity_statements_query(query, entity_id) do
      from(f in query, where: f.entity_id == ^entity_id)
    end
  
  
    def create_equity_statement(%Entity{} = entity, attrs \\ %{}) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:entity, entity)
      |> Repo.insert()
    end
  
  
    def update_equity_statement(%EquityStatement{} = equity_statement, attrs) do
      equity_statement
      |> EquityStatement.changeset(attrs)
      |> Repo.update()
    end
  
  
    def delete_equity_statement(%EquityStatement{} = equity_statement) do
      Repo.delete(equity_statement)
    end
  
    @doc """
    Returns an `%Ecto.Changeset{}` for tracking report changes.
  
    ## Examples
  
        iex> change_equity_statement(report)
        %Ecto.Changeset{source: %Report{}}
  
    """
    def change_equity_statement(%EquityStatement{} = equity_statement) do
      EquityStatement.changeset(equity_statement, %{})
    end
  end
  