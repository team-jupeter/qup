defmodule DemoWeb.InvoiceController do
  use DemoWeb, :controller

  alias Demo.Invoices
  # alias Demo.Invoices.Invoice 
  alias Demo.InvoiceItems 

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end 

  def index(conn, _params, _current_entity) do
    invoices = Invoices.list_invoices()
    render(conn, "index.html", invoices: invoices)
  end


  # def new(conn, _params, _current_entity) do
  #   conn
  # end

  def new(conn, _params, current_entity) do
    invoice_items = InvoiceItems.list_invoice_items(current_entity.id)

    IO.puts "new"
    IO.inspect Enum.at(invoice_items, 0)


    seller_id = Enum.at(invoice_items, 0).seller_id
    seller_name = Enum.at(invoice_items, 0).seller_name
    buyer_id = Enum.at(invoice_items, 0).buyer_id
    buyer_name = Enum.at(invoice_items, 0).buyer_name

    invoice_params = %{
      buyer_id: buyer_id,
      buyer_name: buyer_name,
      seller_id: seller_id, 
      seller_name: seller_name, 
      invoice_items: invoice_items
    }

    case Invoices.create_invoice(invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice created successfully.")
        |> redirect(to: Routes.invoice_path(conn, :show, invoice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_entity) do
    invoice = Invoices.get_invoice!(id)
    render(conn, "show.html", invoice: invoice)
  end

  # def edit(conn, %{"id" => id}, _current_entity) do
  #   invoice = Invoices.get_invoice!(id)
  #   changeset = Invoices.change_invoice(invoice)
  #   render(conn, "edit.html", invoice: invoice, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "invoice" => invoice_params}, _current_entity) do
  #   invoice = Invoices.get_invoice!(id)

  #   case Invoices.update_invoice(invoice, invoice_params) do
  #     {:ok, invoice} ->
  #       conn
  #       |> put_flash(:info, "Invoice updated successfully.")
  #       |> redirect(to: Routes.invoice_path(conn, :show, invoice))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", invoice: invoice, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}, _current_entity) do
  #   invoice = Invoices.get_invoice!(id)
  #   {:ok, _invoice} = Invoices.delete_invoice(invoice)

  #   conn
  #   |> put_flash(:info, "Invoice deleted successfully.")
  #   |> redirect(to: Routes.invoice_path(conn, :index))
  # end
end
