defmodule DemoWeb.CFStatementController do
  use DemoWeb, :controller
  # import Plug.Conn

  alias Demo.CFStatements
  alias Demo.Reports.CFStatement
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

  def show(conn, %{"id" => id}) do
    cf_statement = CFStatements.get_entity_cf_statement(id)

    case cf_statement do
      nil ->
        new(conn, "dummy")

      cf_statement ->
        render(conn, "show.html", cf: cf_statement)
    end
  end

  # def edit(conn, %{"id" => id}) do
  #   cf_statement = CFStatement |> Demo.Repo.get!(id) 
  #   changeset = CFStatements.change_cf_statement(cf_statement)
  #   render(conn, "edit.html", cf: cf_statement, changeset: changeset)
  # end
  def edit(conn, %{"id" => id}) do
    cf_statement =
      cond do
        Families.get_family(id) != nil ->
          family = Families.get_family(id)
          Repo.preload(family, :cf_statement).cf_statement

        Groups.get_group(id) != nil ->
          group = Groups.get_group(id)
          Repo.preload(group, :cf_statement).cf_statement

        Supuls.get_supul(id) != nil ->
          supul = Supuls.get_supul(id)
          Repo.preload(supul, :cf_statement).cf_statement

        StateSupuls.get_state_supul(id) != nil ->
          state_supul = StateSupuls.get_state_supul(id)
          Repo.preload(state_supul, :cf_statement).cf_statement

        NationSupuls.get_nation_supul(id) != nil ->
          nation_supul = NationSupuls.get_nation_supul(id)
          Repo.preload(nation_supul, :cf_statement).cf_statement

        true ->
          "error"
      end

    render(conn, "show.html", cf_statement: cf_statement)
  end

  def update(conn, %{"id" => id, "cf_statement" => cf_statement_params}) do
    cf_statement = CFStatement |> Demo.Repo.get!(id)

    case CFStatements.update_cf_statement(cf_statement, cf_statement_params) do
      {:ok, cf_statement} ->
        conn
        |> put_flash(:info, "CFStatement updated successfully.")

        # |> redirect(to: Routes.cf_statement_path(conn, :show, cf_statement))
        render(conn, "show.html", cf: cf_statement)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", cf_statement: cf_statement, changeset: changeset)
    end
  end

  def new(conn, _params) do
    changeset = CFStatements.change_cf_statement(%CFStatement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cf_statement" => cf_statement_params}, current_entity) do
    case CFStatements.create_cf_statement(current_entity, cf_statement_params) do
      {:ok, cf_statement} ->
        conn
        |> put_flash(:info, "CFStatement created successfully.")
        |> redirect(to: Routes.cf_statement_path(conn, :show, cf_statement))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  '''
    No one can delete any records in supul.
    
    def delete(conn, %{"id" => id}) do
      cf_statement = CFStatements.get_entity_cf_statement!(id) 
      {:ok, _cf_statement} = CFStatements.delete_cf_statement(cf_statement)

      conn
      |> put_flash(:info, "CFStatement deleted successfully.")
      |> redirect(to: Routes.cf_statement_path(conn, :index))
    end
  '''
end
