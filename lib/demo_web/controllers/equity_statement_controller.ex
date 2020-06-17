defmodule DemoWeb.EquityStatementController do
  use DemoWeb, :controller
  # import Plug.Conn

  alias Demo.EquityStatements
  alias Demo.Reports.EquityStatement

  # def action(conn, _) do
  #   args = [conn, conn.params, conn.assigns.current_entity]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  def show(conn, %{"id" => id}) do
    [equity_statement] = EquityStatements.get_entity_equity_statement!(id) 
    case equity_statement do
      nil -> 
        new(conn, "dummy")
      equity_statement ->
        render(conn, "show.html", es: equity_statement)
    end
  end 

  def edit(conn, %{"id" => id}) do
    equity_statement = EquityStatement |> Demo.Repo.get!(id) 
    changeset = EquityStatements.change_equity_statement(equity_statement)
    render(conn, "edit.html", es: equity_statement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "equity_statement" => equity_statement_params}) do
    equity_statement = EquityStatement |> Demo.Repo.get!(id) 

    case EquityStatements.update_equity_statement(equity_statement, equity_statement_params) do
      {:ok, equity_statement} ->
        conn
        |> put_flash(:info, "EquityStatement updated successfully.")
        # |> redirect(to: Routes.equity_statement_path(conn, :show, equity_statement))
        render(conn, "show.html", es: equity_statement)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", equity_statement: equity_statement, changeset: changeset)
    end
  end


  def new(conn, _params) do
    changeset = EquityStatements.change_equity_statement(%EquityStatement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"equity_statement" => equity_statement_params}, current_entity) do
    case EquityStatements.create_equity_statement(current_entity, equity_statement_params) do
      {:ok, equity_statement} ->
        conn
        |> put_flash(:info, "EquityStatement created successfully.")
        |> redirect(to: Routes.equity_statement_path(conn, :show, equity_statement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  '''  
  No one can delete any records in supul.
  
  def delete(conn, %{"id" => id}) do
    equity_statement = EquityStatements.get_entity_equity_statement!(id) 
    {:ok, _equity_statement} = EquityStatements.delete_equity_statement(equity_statement)

    conn
    |> put_flash(:info, "EquityStatement deleted successfully.")
    |> redirect(to: Routes.equity_statement_path(conn, :index))
  end
'''
end
