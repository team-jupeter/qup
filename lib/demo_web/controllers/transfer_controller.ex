defmodule DemoWeb.TransferController do
  use DemoWeb, :controller

  alias Demo.Transfers
  alias Demo.Transfers.Transfer

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

    
  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_entity) do
    transfers = Transfers.list_transfers()
    render(conn, "index.html", transfers: transfers)
  end

  def new(conn, _params, current_entity) do
    changeset = Transfers.change_transfer(%Transfer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transfer" => transfer_params}, current_entity) do
    # case transfer_params.ssu_email != nil do

    case Transfers.create_transfer(transfer_params, current_entity) do 
      {:ok, transfer} ->
        conn
        |> put_flash(:info, "Transfer created successfully.")
        |> redirect(to: Routes.transfer_path(conn, :show, transfer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_entity) do
    transfer = Transfers.get_transfer!(id)
    render(conn, "show.html", transfer: transfer)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    transfer = Transfers.get_transfer!(id)
    changeset = Transfers.change_transfer(transfer)
    render(conn, "edit.html", transfer: transfer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transfer" => transfer_params}) do
    transfer = Transfers.get_transfer!(id)

    case Transfers.update_transfer(transfer, transfer_params) do
      {:ok, transfer} ->
        conn
        |> put_flash(:info, "Transfer updated successfully.")
        |> redirect(to: Routes.transfer_path(conn, :show, transfer))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transfer: transfer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transfer = Transfers.get_transfer!(id)
    {:ok, _transfer} = Transfers.delete_transfer(transfer)

    conn
    |> put_flash(:info, "Transfer deleted successfully.")
    |> redirect(to: Routes.transfer_path(conn, :index))
  end
end
