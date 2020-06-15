defmodule DemoWeb.GabAccountController do
  use DemoWeb, :controller

  alias Demo.GabAccounts
  alias Demo.GabAccounts.GabAccount
  # alias Demo.Accounts.Entity

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, _current_entity) do
    render(conn, "index.html")
  end

  def new(conn, _params, _current_entity) do
    changeset = GabAccounts.change_gab_account(%GabAccount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gab_account" => gab_account_params}, current_entity) do
    case GabAccounts.create_gab_account(current_entity, gab_account_params) do
      {:ok, gab_account} ->
        conn
        |> put_flash(:info, "Gab account created successfully.")
        |> redirect(to: Routes.gab_account_path(conn, :show, gab_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_entity) do
    gab_account = GabAccounts.get_entity_gab_account!(current_entity, id)
    render(conn, "show.html", gab_account: gab_account)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    gab_account = GabAccounts.get_entity_gab_account!(current_entity, id)
    changeset = GabAccounts.change_gab_account(gab_account)
    render(conn, "edit.html", gab_account: gab_account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gab_account" => gab_account_params}, current_entity) do
    gab_account = GabAccounts.get_entity_gab_account!(current_entity, id)

    case GabAccounts.update_gab_account(gab_account, gab_account_params) do
      {:ok, gab_account} ->
        conn
        |> put_flash(:info, "Gab account updated successfully.")
        |> redirect(to: Routes.gab_account_path(conn, :show, gab_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gab_account: gab_account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_entity) do
    gab_account = GabAccounts.get_entity_gab_account!(current_entity, id)
    {:ok, _gab_account} = GabAccounts.delete_gab_account(gab_account)

    conn
    |> put_flash(:info, "Gab account deleted successfully.")
    |> redirect(to: Routes.gab_account_path(conn, :index))
  end
end
