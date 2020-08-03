defmodule DemoWeb.GabAccountController do
  use DemoWeb, :controller

  alias Demo.GabAccounts
  alias Demo.GabAccounts.GabAccount

  def index(conn, _params) do
    gab_accounts = GabAccounts.list_gab_accounts()
    render(conn, "index.html", gab_accounts: gab_accounts)
  end

  def new(conn, _params) do
    changeset = GabAccounts.change_gab_account(%GabAccount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gab_account" => gab_account_params}) do
    case GabAccounts.create_gab_account(gab_account_params) do
      {:ok, gab_account} ->
        conn
        |> put_flash(:info, "Gab account created successfully.")
        |> redirect(to: Routes.gab_account_path(conn, :show, gab_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.puts "gab_account"
    gab_account = GabAccounts.get_entity_gab_account(id)
    IO.inspect gab_account
    render(conn, "show.html", gab_account: gab_account)
  end

  def edit(conn, %{"id" => id}) do
    gab_account = GabAccounts.get_gab_account!(id)
    changeset = GabAccounts.change_gab_account(gab_account)
    render(conn, "edit.html", gab_account: gab_account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gab_account" => gab_account_params}) do
    gab_account = GabAccounts.get_gab_account!(id)

    case GabAccounts.update_gab_account(gab_account, gab_account_params) do
      {:ok, gab_account} ->
        conn
        |> put_flash(:info, "Gab account updated successfully.")
        |> redirect(to: Routes.gab_account_path(conn, :show, gab_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gab_account: gab_account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gab_account = GabAccounts.get_gab_account!(id)
    {:ok, _gab_account} = GabAccounts.delete_gab_account(gab_account)

    conn
    |> put_flash(:info, "Gab account deleted successfully.")
    |> redirect(to: Routes.gab_account_path(conn, :index))
  end
end
