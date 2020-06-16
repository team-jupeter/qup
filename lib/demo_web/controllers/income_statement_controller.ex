#---
# Excerpted from "Programming Phoenix 1.4",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix14 for more book information.
#---
defmodule DemoWeb.IncomeStatementController do
  use DemoWeb, :controller

  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  # alias Demo.Business.Entity



  def index(conn, _params, _current_entity) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id}, current_entity) do
    income_statement = IncomeStatements.get_entity_income_statement!(current_entity, id) 
    render(conn, "show.html", income_statement: income_statement)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    income_statement = IncomeStatements.get_entity_income_statement!(current_entity, id) 
    changeset = IncomeStatements.change_income_statement(income_statement)
    render(conn, "edit.html", income_statement: income_statement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "income_statement" => income_statement_params}, current_entity) do
    income_statement = IncomeStatements.get_entity_income_statement!(current_entity, id) 

    case IncomeStatements.update_income_statement(income_statement, income_statement_params) do
      {:ok, income_statement} ->
        conn
        |> put_flash(:info, "IncomeStatement updated successfully.")
        |> redirect(to: Routes.income_statement_path(conn, :show, income_statement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", income_statement: income_statement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_entity) do
    income_statement = IncomeStatements.get_entity_income_statement!(current_entity, id) 
    {:ok, _income_statement} = IncomeStatements.delete_income_statement(income_statement)

    conn
    |> put_flash(:info, "IncomeStatement deleted successfully.")
    |> redirect(to: Routes.income_statement_path(conn, :index))
  end

  def new(conn, _params, _current_entity) do
    changeset = IncomeStatements.change_income_statement(%IncomeStatement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"income_statement" => income_statement_params}, current_entity) do
    case IncomeStatements.create_income_statement(current_entity, income_statement_params) do
      {:ok, income_statement} ->
        conn
        |> put_flash(:info, "IncomeStatement created successfully.")
        |> redirect(to: Routes.income_statement_path(conn, :show, income_statement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
