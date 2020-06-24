defmodule DemoWeb.ProductAuth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    IO.puts "ProductAuth call"
    IO.inspect conn
    product_id = get_session(conn, :product_id)
    product = product_id && Demo.Business.get_product!(product_id)
    a = assign(conn, :current_product, product)
    IO.inspect a
    assign(conn, :current_product, product)
  end


  def product_login(conn, product) do
    IO.puts "product_login"
    # IO.inspect conn
    conn
    |> assign(:current_product, product)
    # |> IO.inspect
    |> put_session(:product_id, product.id)
    # |> IO.inspect
    |> configure_session(renew: true)
    # |> IO.inspect
  end

  def logout(conn) do
    # IO.puts "logout"
    # IO.inspect conn
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
