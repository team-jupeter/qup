defmodule DemoWeb.EntityAuth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # IO.puts "call"
    # IO.inspect conn
    entity_id = get_session(conn, :entity_id)
    entity = entity_id && Demo.Business.get_entity!(entity_id)
    # a = assign(conn, :current_entity, entity)
    # IO.inspect a
    assign(conn, :current_entity, entity)
  end


  def entity_login(conn, entity) do
    IO.puts "entity_login"
    # IO.inspect conn
    conn
    |> assign(:current_entity, entity)
    # |> IO.inspect
    |> put_session(:entity_id, entity.id)
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

  def authenticate_entity(conn, _opts) do
    if conn.assigns.current_entity do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
