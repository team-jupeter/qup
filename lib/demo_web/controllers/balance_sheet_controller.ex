# ---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
# ---
defmodule DemoWeb.BalanceSheetController do
  use DemoWeb, :controller

  # alias Demo.Reports
  alias Demo.Reports.BalanceSheet
  alias Demo.BalanceSheets
  # alias Demo.Accounts.Entity

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _current_entity) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id}, current_entity) do
    balance_sheet = BalanceSheets.get_entity_balance_sheet!(current_entity, id)
    render(conn, "show.html", balance_sheet: balance_sheet)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    balance_sheet = BalanceSheets.get_entity_balance_sheet!(current_entity, id)
    changeset = BalanceSheets.change_balance_sheet(balance_sheet)
    render(conn, "edit.html", balance_sheet: balance_sheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "balance_sheet" => balance_sheet_params}, current_entity) do
    balance_sheet = BalanceSheets.get_entity_balance_sheet!(current_entity, id)

    case BalanceSheets.update_balance_sheet(balance_sheet, balance_sheet_params) do
      {:ok, balance_sheet} ->
        conn
        |> put_flash(:info, "BalanceSheet updated successfully.")
        |> redirect(to: Routes.balance_sheet_path(conn, :show, balance_sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", balance_sheet: balance_sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_entity) do
    balance_sheet = BalanceSheets.get_entity_balance_sheet!(current_entity, id)
    {:ok, _balance_sheet} = BalanceSheets.delete_balance_sheet(balance_sheet)

    conn
    |> put_flash(:info, "BalanceSheet deleted successfully.")
    |> redirect(to: Routes.balance_sheet_path(conn, :index))
  end

  def new(conn, _params, _current_entity) do
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
end
