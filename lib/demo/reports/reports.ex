defmodule Demo.Reports do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.Report


  def list_reports do
    Repo.all(Report)
  end


  def get_report!(id), do: Repo.get!(Report, id)


  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end


  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end


  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_report(%Report{} = report) do
    Report.changeset(report, %{})
  end
end
