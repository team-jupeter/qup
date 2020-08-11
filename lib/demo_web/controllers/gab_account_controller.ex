defmodule DemoWeb.GabAccountController do
  use DemoWeb, :controller
  alias Demo.Repo

  alias Demo.GabAccounts
  alias Demo.GabAccounts.GabAccount
  alias Demo.Families
  alias Demo.Groups
  alias Demo.Supuls
  alias Demo.StateSupuls
  alias Demo.NationSupuls

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]
  
  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_entity) do
    gab_accounts = GabAccounts.list_gab_accounts()
    render(conn, "index.html", gab_accounts: gab_accounts)
  end

  def new(conn, _params, current_entity) do
    changeset = GabAccounts.change_gab_account(%GabAccount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gab_account" => gab_account_params}, current_entity) do
    case GabAccounts.create_gab_account(gab_account_params) do
      {:ok, gab_account} ->
        conn
        |> put_flash(:info, "Gab account created successfully.")
        |> redirect(to: Routes.gab_account_path(conn, :show, gab_account))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_entity) do
      gab_account = GabAccounts.get_entity_gab_account!(id)
      render(conn, "show.html", gab_account: gab_account)
    # IO.puts("gab account controller show")

    # gab_account =
    #   cond do
    #     Families.get_family(id) != nil ->
    #       family = Families.get_family(id)
    #       Repo.preload(family, :gab_account).gab_account

    #     Groups.get_group(id) != nil ->
    #       group = Groups.get_group(id)
    #       Repo.preload(group, :gab_account).gab_account

    #     Supuls.get_supul(id) != nil ->
    #       supul = Supuls.get_supul(id)
    #       Repo.preload(supul, :gab_account).gab_account

    #     StateSupuls.get_state_supul(id) != nil ->
    #       state_supul = StateSupuls.get_state_supul(id)
    #       Repo.preload(state_supul, :gab_account).gab_account

    #     NationSupuls.get_nation_supul(id) != nil ->
    #       nation_supul = NationSupuls.get_nation_supul(id)
    #       Repo.preload(nation_supul, :gab_account).gab_account

    #     true ->
    #       "error"
    #   end

    # render(conn, "show.html", gab_account: gab_account)
  end 

  def edit(conn, %{"id" => id}, current_entity) do
    gab_account = GabAccounts.get_entity_gab_account!(current_entity.id)
    changeset = GabAccounts.change_gab_account(gab_account)
    render(conn, "edit.html", gab_account: gab_account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gab_account" => gab_account_params}, current_entity) do
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

  def send_money(receiver_email, currency, amount, current_entity) do
    amount = Decimal.from_float(amount)
    GabAccounts.send_t1(current_entity, receiver_email, currency, amount)
  end
end
