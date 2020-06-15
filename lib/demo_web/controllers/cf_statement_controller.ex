#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
defmodule DemoWeb.CFStatementController do
  use DemoWeb, :controller

  alias Demo.CFStatements
  alias Demo.Reports.CFStatement
  # alias Demo.Accounts.Entity

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _current_entity) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id}, current_entity) do
    cf_statement = CFStatements.get_entity_cf_statement!(current_entity, id) 
    render(conn, "show.html", cf_statement: cf_statement)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    cf_statement = CFStatements.get_entity_cf_statement!(current_entity, id) 
    changeset = CFStatements.change_cf_statement(cf_statement)
    render(conn, "edit.html", cf_statement: cf_statement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cf_statement" => cf_statement_params}, current_entity) do
    cf_statement = CFStatements.get_entity_cf_statement!(current_entity, id) 

    case CFStatements.update_cf_statement(cf_statement, cf_statement_params) do
      {:ok, cf_statement} ->
        conn
        |> put_flash(:info, "CashFlowStatement updated successfully.")
        |> redirect(to: Routes.cf_statement_path(conn, :show, cf_statement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cf_statement: cf_statement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_entity) do
    cf_statement = CFStatements.get_entity_cf_statement!(current_entity, id) 
    {:ok, _cf_statement} = CFStatements.delete_cf_statement(cf_statement)

    conn
    |> put_flash(:info, "CashFlowStatement deleted successfully.")
    |> redirect(to: Routes.cf_statement_path(conn, :index))
  end

  def new(conn, _params, _current_entity) do
    changeset = CFStatements.change_cf_statement(%CFStatement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cf_statement" => cf_statement_params}, current_entity) do
    case CFStatements.create_cf_statement(current_entity, cf_statement_params) do
      {:ok, cf_statement} ->
        conn
        |> put_flash(:info, "CashFlowStatement created successfully.")
        |> redirect(to: Routes.cf_statement_path(conn, :show, cf_statement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
