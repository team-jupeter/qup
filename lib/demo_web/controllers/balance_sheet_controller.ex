# ---
# Excerpted bsom "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
# ---
defmodule DemoWeb.BalanceSheetController do
  use DemoWeb, :controller
  # import Plug.Conn
  alias Demo.Repo
  alias Demo.BalanceSheets
  alias Demo.Reports.BalanceSheet
  alias Demo.Groups
  alias Demo.Families
  alias Demo.Supuls
  alias Demo.StateSupuls
  alias Demo.NationSupuls

  # def action(conn, _) do
  #   args = [conn, conn.params, conn.assigns.current_entity]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def show(conn, %{"id" => id}) do
    balance_sheet = BalanceSheets.get_entity_balance_sheet(id)

    case balance_sheet do
      nil ->
        new(conn, "dummy")

      balance_sheet ->
        render(conn, "show.html", balance_sheet: balance_sheet)
    end
  end

  def edit(conn, %{"id" => id}) do
    balance_sheet =
      cond do
        Families.get_family(id) != nil ->
          family = Families.get_family(id)
          balance_sheet = Repo.preload(family, :balance_sheet).balance_sheet

        Groups.get_group(id) != nil ->
          group = Groups.get_group(id)
          balance_sheet = Repo.preload(group, :balance_sheet).balance_sheet

        Supuls.get_supul(id) != nil ->
          supul = Supuls.get_supul(id)
          balance_sheet = Repo.preload(supul, :balance_sheet).balance_sheet

        StateSupuls.get_state_supul(id) != nil ->
          state_supul = StateSupuls.get_state_supul(id)
          balance_sheet = Repo.preload(state_supul, :balance_sheet).balance_sheet

        NationSupuls.get_nation_supul(id) != nil ->
          nation_supul = NationSupuls.get_nation_supul(id)
          balance_sheet = Repo.preload(nation_supul, :balance_sheet).balance_sheet

        true ->
          "error"
      end

    render(conn, "show.html", balance_sheet: balance_sheet)
  end

  def update(conn, %{"id" => id, "balance_sheet" => balance_sheet_params}) do
    balance_sheet = BalanceSheet |> Demo.Repo.get!(id)

    case BalanceSheets.update_balance_sheet(balance_sheet, balance_sheet_params) do
      {:ok, balance_sheet} ->
        conn
        |> put_flash(:info, "BalanceSheet updated successfully.")

        # |> redirect(to: Routes.balance_sheet_path(conn, :show, balance_sheet))
        render(conn, "show.html", balance_sheet: balance_sheet)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", balance_sheet: balance_sheet, changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = BalanceSheets.change_balance_sheet(%BalanceSheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"balance_sheet" => balance_sheet_params}, current_entity) do
    case BalanceSheets.create_balance_sheet(current_entity, balance_sheet_params) do
      {:ok, balance_sheet} ->
        conn
        |> put_flash(:info, "BalanceSheet created successfully.")
        |> redirect(to: Routes.balance_sheet_path(conn, :show, balance_sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  '''
    No one can delete any records in supul.
    
    def delete(conn, %{"id" => id}) do
      balance_sheet = BalanceSheets.get_entity_balance_sheet!(id) 
      {:ok, _balance_sheet} = BalanceSheets.delete_balance_sheet(balance_sheet)

      conn
      |> put_flash(:info, "BalanceSheet deleted successfully.")
      |> redirect(to: Routes.balance_sheet_path(conn, :index))
    end
  '''
end
