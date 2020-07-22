defmodule Demo.CFStatements do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.CFStatement
  # alias Demo.Entities.Entity

  def get_cf_statement!(id), do: Repo.get!(CFStatement, id)

  def get_entity_cf_statement!(entity_id) do
    CFStatement
    |> entity_cf_statements_query(entity_id)
    |> Repo.all
  end

  defp entity_cf_statements_query(query, entity_id) do    
    from(f in query, where: f.entity_id == ^entity_id)
  end

 
  def create_cf_statement(%CFStatement{} = entity, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Repo.insert()
  end

  def create_public_cf_statement(attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
    |> Ecto.Changeset.put_assoc(:entity, attrs.entity)
    |> Repo.insert()
  end

  def create_private_cf_statement(attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
    |> Ecto.Changeset.put_assoc(:entity, attrs.entity)
    |> Repo.insert()
  end

  def create_supul_cf_statement(attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, attrs.supul)
    |> Repo.insert()
  end

  def create_state_supul_cf_statement(attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, attrs.state_supul)
    |> Repo.insert()
  end

  def create_nation_supul_cf_statement(attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
    |> Repo.insert()
  end

  def create_tax_cf_statement(attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, attrs.taxation)
    |> Ecto.Changeset.put_assoc(:nation_supul, attrs.nation_supul)
    |> Repo.insert()
  end


  def update_cf_statement(%CFStatement{} = cf_statement, attrs) do
    cf_statement
    |> CFStatement.changeset(attrs)
    |> Repo.update()
  end

  def change_cf_statement(%CFStatement{} = cf_statement) do
    CFStatement.changeset(cf_statement, %{})
  end
  
'''
  def delete_cf_statement(%CFStatement{} = cf_statement) do
    Repo.delete(cf_statement)
  end
'''
end
