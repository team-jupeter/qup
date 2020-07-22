defmodule Demo.FinancialReports do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.FinancialReport
  # alias Demo.Entities.Entity

  def get_financial_report!(id), do: Repo.get!(FinancialReport, id)

  def get_entity_financial_report!(entity_id) do 
    FinancialReport
    |> entity_financial_reports_query(entity_id)
    |> Repo.all
  end

  defp entity_financial_reports_query(query, entity_id) do    
    from(f in query, where: f.entity_id == ^entity_id)
  end

 
  def create_tax_financial_report(attrs) do
    FinancialReport.tax_changeset(attrs) 
    |> Repo.insert()
  end
 
  def create_public_financial_report(attrs) do
    FinancialReport.public_changeset(attrs) 
    |> Repo.insert()
  end
 
  def create_financial_report(attrs) do
    FinancialReport.changeset(attrs) 
    |> Repo.insert()
  end
 
  def create_nation_supul_financial_report(attrs) do
    FinancialReport.nation_supul_changeset(attrs)
    |> Repo.insert()
  end

  def create_state_supul_financial_report(attrs) do
    FinancialReport.state_supul_changeset(attrs)
    |> Repo.insert() 
  end

  def create_supul_financial_report(attrs) do
    FinancialReport.supul_changeset(attrs)
    |> Repo.insert()
  end

 
  def create_entity_financial_report(entity, attrs) do
    entity
    |> FinancialReport.entity_changeset(attrs)
    |> Repo.insert()
  end


  def update_financial_report(%FinancialReport{} = financial_report, attrs) do
    financial_report
    |> FinancialReport.changeset(attrs)
    |> Repo.update()
  end

  def change_financial_report(attrs) do
    FinancialReport.changeset(attrs)
  end
  
'''
  def delete_financial_report(%FinancialReport{} = financial_report) do
    Repo.delete(financial_report)
  end
'''
end
