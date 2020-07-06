defmodule DemoWeb.ItemController do
  use DemoWeb, :controller

  alias Demo.Items
  alias Demo.Invoices.Item
  alias Demo.Business.Products
  alias DemoWeb.InvoiceItemController

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end 

  def index(conn, _params, _current_entity) do
    items = Products.list_products()
    render(conn, "index.html", items: items)
  end
 
  def new(conn, _params, _current_entity) do
    changeset = Items.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}, _current_entity) do
    # IO.puts "item create"
    case Items.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: Routes.item_path(conn, :show, item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_entity) do
    item = Products.get_product!(id)
    render(conn, "show.html", item: item)
  end 

  def edit(conn, %{"id" => id}, current_entity) do
    item = Products.get_product!(id)

    IO.inspect item

    buyer_id = current_entity.id 
    seller_id = item.entity_id
 
    IO.inspect seller_id

    
    params = %{ "invoice_item" => %{
      buyer_id: buyer_id,
      seller_id: seller_id,
      item_name: item.name,
      price: item.price,
      quantity: 3} 
    }
    
    InvoiceItemController.create(conn, params)
    # changeset = Items.change_item(item)
    # render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}, _current_entity) do
    item = Items.get_item!(id)

    case Items.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: Routes.item_path(conn, :show, item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Items.get_item!(id)
    {:ok, _item} = Items.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: Routes.item_path(conn, :index))
  end
end
