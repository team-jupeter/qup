defmodule Demo.BalanceSheets do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.BalanceSheet
  alias Demo.Business.Entity

  def get_balance_sheet!(id), do: Repo.get!(BalanceSheet, id)

  def get_entity_balance_sheet!(entity_id) do
    BalanceSheet
    |> entity_balance_sheets_query(entity_id)
    |> Repo.all
  end

  defp entity_balance_sheets_query(query, entity_id) do    
    from(f in query, where: f.entity_id == ^entity_id)
  end

 
  def create_balance_sheet(%Entity{} = entity, attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  def update_balance_sheet(%BalanceSheet{} = balance_sheet, attrs) do
    BalanceSheet.changeset(balance_sheet, attrs) 
    |> Repo.update!()
  end

  def minus_abc(%BalanceSheet{} = balance_sheet, amount) do
    balance_sheet 
    |> BalanceSheet.changeset_minus_abc(amount)
    |> Repo.update()

    entity = Demo.Business.get_entity!(balance_sheet.entity_id)
    Demo.Business.update_entity(entity, balance_sheet.gab_balance)
  end

  def change_balance_sheet(%BalanceSheet{} = balance_sheet) do
    BalanceSheet.changeset(balance_sheet, %{})
  end
  
'''
  def delete_balance_sheet(%BalanceSheet{} = balance_sheet) do
    Repo.delete(balance_sheet)
  end
'''
end
