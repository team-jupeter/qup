defmodule Demo.Reports do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.FinancialReport


  def list_reports do
    Repo.all(FinancialReport)
  end


  def get_report!(id), do: Repo.get!(FinancialReport, id)


  def create_report(attrs \\ %{}) do
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Repo.insert()
  end


  def update_report(%FinancialReport{} = financial_report, attrs) do
    financial_report
    |> FinancialReport.changeset(attrs)
    |> Repo.update()
  end


  def delete_report(%FinancialReport{} = financial_report) do
    Repo.delete(financial_report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_report(%FinancialReport{} = financial_report) do
    FinancialReport.changeset(financial_report, %{})
  end
end
