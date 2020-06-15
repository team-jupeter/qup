defmodule Demo.FinancialReports do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.FinancialReport
  # alias Demo.Reports.Report
  alias Demo.Accounts.Entity


  def get_financial_report!(id), do: Repo.get!(FinancialReport, id)

  def get_entity_financial_report!(%Entity{} = entity, id) do
    FinancialReport
    |> entity_financial_reports_query(entity)
    |> Repo.get!(id)
  end

  defp entity_financial_reports_query(query, %Entity{id: entity_id}) do
    from(f in query, where: f.entity_id == ^entity_id)
  end


  def create_financial_report(%Entity{} = entity, attrs \\ %{}) do
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end


  def update_financial_report(%FinancialReport{} = financial_report, attrs) do
    financial_report
    |> FinancialReport.changeset(attrs)
    |> Repo.update()
  end


  def delete_financial_report(%FinancialReport{} = financial_report) do
    Repo.delete(financial_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_financial_report(%FinancialReport{} = financial_report) do
    FinancialReport.changeset(financial_report, %{})
  end
end
