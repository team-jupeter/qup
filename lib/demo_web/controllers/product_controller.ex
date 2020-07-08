#---
defmodule DemoWeb.ProductController do
  use DemoWeb, :controller

  alias Demo.Business.Products
  alias Demo.Business.Product
 
  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end 

  def index(conn, _params, current_entity) do
    products = Products.list_entity_products(current_entity) 
    IO.puts "Product controller index"
    render(conn, "index.html", products: products)
  end 

  def show(conn, %{"id" => id}, current_entity) do
    product = Products.get_entity_product!(current_entity, id) 
    render(conn, "show.html", product: product) 
  end
  
  def edit(conn, %{"id" => id}, current_entity) do
    product = Products.get_entity_product!(current_entity, id) 
    changeset = Products.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}, current_entity) do
    product = Products.get_entity_product!(current_entity, id) 
 
    case Products.update_product(product, product_params) do
      {:ok, product} ->
        conn 
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_entity) do
    product = Products.get_entity_product!(current_entity, id) 
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: Routes.product_path(conn, :index))
  end

  def new(conn, _params, _current_entity) do
    changeset = Products.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}, current_entity) do
    IO.inspect current_entity
    
    case Products.create_product(current_entity, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
