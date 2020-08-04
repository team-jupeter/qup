defmodule DemoWeb.ProductAuth do
  import Plug.Conn

  alias Demo.Products

  def init(opts), do: opts

  def call(conn, _opts) do
    product_id = get_session(conn, :product_id) 
    product = product_id && Products.get_product!(product_id)
    assign(conn, :current_product, product)
  end


  def product_login(conn, product) do
    conn
    |> assign(:current_product, product)
    |> put_session(:product_id, product.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true) # initialize conn
  end

  import Phoenix.Controller
  alias DemoWeb.Router.Helpers, as: Routes

  def authenticate_product(conn, _opts) do
    if conn.assigns.current_product do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
