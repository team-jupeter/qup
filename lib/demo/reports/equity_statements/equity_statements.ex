defmodule Demo.EquityStatements do

    import Ecto.Query, warn: false
    alias Demo.Repo
  
    alias Demo.Reports.EquityStatement
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
  
  
    def create_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Repo.insert()
    end

    def create_equity_statement(%Entity{} = entity, attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:entity, entity)
      |> Repo.insert()
    end
  
    def create_private_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:entity, attrs.entity)
      |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
      |> Repo.insert()
    end
  
    def create_public_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:entity, attrs.entity)
      |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
      |> Repo.insert()
    end
    
    def create_supul_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
      |> Repo.insert()
    end
    
    def create_state_supul_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:state_supul, attrs.state_supul)
      |> Repo.insert()
    end
  
    def create_nation_supul_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
      |> Repo.insert()
    end
  
    def create_tax_equity_statement(attrs) do
      %EquityStatement{}
      |> EquityStatement.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:taxation, attrs.taxation)
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
  