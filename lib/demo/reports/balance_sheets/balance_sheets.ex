defmodule Demo.BalanceSheets do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.BalanceSheet
  # alias Demo.Reports.Report
  alias Demo.Business.Entity
  # alias Demo.Reports.FinancialReport

  def get_balance_sheet!(id), do: Repo.get!(BalanceSheet, id)

  def get_entity_balance_sheet!(%Entity{} = entity, id) do
    BalanceSheet
    |> entity_balance_sheets_query(entity)
    |> Repo.get!(id)
  end

  defp entity_balance_sheets_query(query, %Entity{id: entity_id}) do
    from(f in query, where: f.entity_id == ^entity_id)
  end


  def create_balance_sheet(%Entity{} = entity, attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end


  def update_balance_sheet(%BalanceSheet{} = balance_sheet, attrs) do
    balance_sheet
    |> BalanceSheet.changeset(attrs)
    |> Repo.update()
  end


  def delete_balance_sheet(%BalanceSheet{} = balance_sheet) do
    Repo.delete(balance_sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_balance_sheet(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_balance_sheet(%BalanceSheet{} = balance_sheet) do
    BalanceSheet.changeset(balance_sheet, %{})
  end
end
