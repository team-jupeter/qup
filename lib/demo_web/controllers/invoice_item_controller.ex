defmodule DemoWeb.InvoiceItemController do
  use DemoWeb, :controller

  alias Demo.InvoiceItems
alias Demo.Invoices.InvoiceItem 

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end 


  def index(conn, _params, current_entity) do
    buyer_id = current_entity.id
    
    IO.inspect buyer_id

    invoice_items = InvoiceItems.list_invoice_items(buyer_id)
    render(conn, "index.html", invoice_items: invoice_items)
  end

  def new(conn, _params, current_entity) do
    buyer_id = current_entity.id
    changeset = InvoiceItems.change_invoice_item(%InvoiceItem{}, %{buyer_id: buyer_id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"invoice_item" => invoice_item_params}) do
    case InvoiceItems.create_invoice_item(invoice_item_params) do 
      {:ok, invoice_item} -> 
        conn
        |> put_flash(:info, "InvoiceItem created successfully.")
        |> redirect(to: Routes.invoice_item_path(conn, :show, invoice_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_entity) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    render(conn, "show.html", invoice_item: invoice_item)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    buyer_id = current_entity.id

    changeset = InvoiceItems.change_invoice_item(invoice_item, %{buyer_id: buyer_id})
    render(conn, "edit.html", invoice_item: invoice_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_item" => invoice_item_params}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)

    case InvoiceItems.update_invoice_item(invoice_item, invoice_item_params) do
      {:ok, invoice_item} ->
        conn
        |> put_flash(:info, "InvoiceItem updated successfully.")
        |> redirect(to: Routes.invoice_item_path(conn, :show, invoice_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invoice_item: invoice_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    {:ok, _invoice_item} = InvoiceItems.delete_invoice_item(invoice_item)

    conn
    |> put_flash(:info, "InvoiceItem deleted successfully.")
    |> redirect(to: Routes.invoice_item_path(conn, :index))
  end
end
