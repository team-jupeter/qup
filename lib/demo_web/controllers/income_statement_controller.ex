defmodule DemoWeb.IncomeStatementController do
  use DemoWeb, :controller
  # import Plug.Conn

  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Repo
  alias Demo.Families
  alias Demo.Groups
  alias Demo.Supuls
  alias Demo.StateSupuls
  alias Demo.NationSupuls
  # def action(conn, _) do
  #   args = [conn, conn.params, conn.assigns.current_entity]
  #   apply(__MODULE__, action_name(conn), args)
  # end

  # def index(conn, _params, current_entity_id) do
  #   income_statements = IncomeStatements.list_income_statements(current_entity_id) 
  #   render(conn, "index.html", is: income_statements)
  # end

  def show(conn, %{"id" => id}) do
    income_statement = IncomeStatements.get_entity_income_statement(id)

    case income_statement do
      nil ->
        new(conn, "dummy")

      income_statement ->
        render(conn, "show.html", income_statement: income_statement)
    end
  end

  def edit(conn, %{"id" => id}) do
    income_statement =
      cond do
        Families.get_family(id) != nil ->
          family = Families.get_family(id)
          Repo.preload(family, :income_statement).income_statement

        Groups.get_group(id) != nil ->
          group = Groups.get_group(id)
          Repo.preload(group, :income_statement).income_statement

        Supuls.get_supul(id) != nil ->
          supul = Supuls.get_supul(id)
          Repo.preload(supul, :income_statement).income_statement

        StateSupuls.get_state_supul(id) != nil ->
          state_supul = StateSupuls.get_state_supul(id)
          Repo.preload(state_supul, :income_statement).income_statement

        NationSupuls.get_nation_supul(id) != nil ->
          nation_supul = NationSupuls.get_nation_supul(id)
          Repo.preload(nation_supul, :income_statement).income_statement

        true ->
          "error"
      end

    render(conn, "show.html", income_statement: income_statement)
  end

  def update(conn, %{"id" => id, "income_statement" => income_statement_params}) do
    income_statement = IncomeStatement |> Demo.Repo.get!(id)

    case IncomeStatements.update_income_statement(income_statement, income_statement_params) do
      {:ok, income_statement} ->
        conn
        |> put_flash(:info, "IncomeStatement updated successfully.")

        # |> redirect(to: Routes.income_statement_path(conn, :show, income_statement))
        render(conn, "show.html", is: income_statement)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", income_statement: income_statement, changeset: changeset)
    end
  end

  def new(conn, _params) do
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

  '''
    No one can delete any records in supul.
    
    def delete(conn, %{"id" => id}) do
      income_statement = IncomeStatements.get_entity_income_statement!(id) 
      {:ok, _income_statement} = IncomeStatements.delete_income_statement(income_statement)

      conn
      |> put_flash(:info, "IncomeStatement deleted successfully.")
      |> redirect(to: Routes.income_statement_path(conn, :index))
    end
  '''
end
