defmodule DemoWeb.DepositController do
  use DemoWeb, :controller

  alias Demo.Deposits
  alias Demo.Deposits.Deposit
  
  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_entity) do
    deposits = Deposits.list_deposits()
    render(conn, "index.html", deposits: deposits)
  end

  def new(conn, _params, current_entity) do
    changeset = Deposits.change_deposit(%Deposit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deposit" => deposit_params}, current_entity) do
    case Deposits.create_deposit(deposit_params) do
      {:ok, deposit} ->
        conn
        |> put_flash(:info, "Deposit created successfully.")
        |> redirect(to: Routes.deposit_path(conn, :show, deposit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_entity) do
    deposit = Deposits.get_deposit!(id)
    render(conn, "show.html", deposit: deposit)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    deposit = Deposits.get_deposit!(id)
    changeset = Deposits.change_deposit(deposit)
    render(conn, "edit.html", deposit: deposit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deposit" => deposit_params}, current_entity) do
    deposit = Deposits.get_deposit!(id)

    case Deposits.update_deposit(deposit, deposit_params) do
      {:ok, deposit} ->
        conn
        |> put_flash(:info, "Deposit updated successfully.")
        |> redirect(to: Routes.deposit_path(conn, :show, deposit))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", deposit: deposit, changeset: changeset)
    end
  end

end
