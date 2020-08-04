defmodule DemoWeb.ItemController do
  use DemoWeb, :controller

  alias Demo.Items
  alias Demo.Invoices.Item
  alias Demo.Products
  alias Demo.Products.Product
  alias Demo.Entities.Entity
  alias DemoWeb.InvoiceItemController
  alias Demo.Repo
  import Ecto.Query, only: [from: 2]

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :cart, :create, :show]

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
    IO.puts("show(conn, current_entity)")

    item = Products.get_product!(id)
    product = Products.get_product!(id)
    render(conn, "show.html", item: item, product: product)
  end

  def edit(conn, %{"id" => id}, _current_entity) do
    item = Products.get_product!(id)
    changeset = Items.change_item(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def cart(conn, %{"item_id" => id}, current_entity) do
    item = Products.get_product!(id)

    buyer_id = current_entity.id
    buyer_name = Repo.one(from e in Entity, where: e.id == ^buyer_id, select: e.name)
    buyer_supul_id = Repo.one(from e in Entity, where: e.id == ^buyer_id, select: e.supul_id)
    buyer_supul_name = Repo.one(from e in Entity, where: e.id == ^buyer_id, select: e.supul_name)

    seller_id = item.entity_id
    
    seller_name = Repo.one(from e in Entity, where: e.id == ^seller_id, select: e.name)

    seller_supul_name =
      Repo.one(from e in Entity, where: e.id == ^seller_id, select: e.supul_name)

    seller_supul_id = Repo.one(from e in Entity, where: e.id == ^seller_id, select: e.supul_id)

    params = %{
      "invoice_item" => %{
        buyer_id: buyer_id,
        buyer_name: buyer_name,
        buyer_supul_name: buyer_supul_name,
        buyer_supul_id: buyer_supul_id,
        seller_id: seller_id,
        seller_name: seller_name,
        seller_supul_id: seller_supul_id,
        seller_supul_name: seller_supul_name,
        item_name: item.name,
        price: item.price,
        quantity: 1
      }
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
