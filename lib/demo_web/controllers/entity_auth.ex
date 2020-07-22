defmodule DemoWeb.EntityAuth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    entity_id = get_session(conn, :entity_id)
    entity = entity_id && Demo.Entities.get_entity!(entity_id)
    # a = assign(conn, :current_entity, entity)
    assign(conn, :current_entity, entity)
  end 

 
  def entity_login(conn, entity) do
    conn
    |> assign(:current_entity, entity)
    |> put_session(:entity_id, entity.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
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
