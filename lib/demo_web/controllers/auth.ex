defmodule DemoWeb.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # IO.puts "call"
    # IO.inspect conn
    user_id = get_session(conn, :user_id)
    user = user_id && Demo.Accounts.get_user(user_id)
    # a = assign(conn, :current_user, user)
    # IO.inspect a
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    # IO.puts "login"
    # IO.inspect conn
    conn
    |> assign(:current_user, user)
    # |> IO.inspect
    |> put_session(:user_id, user.id)
    # |> IO.inspect
    |> configure_session(renew: true)
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

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  # def authenticate_entity(conn, _opts) do
  #   if conn.assigns.current_entity do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You must be logged in to access that page")
  #     |> redirect(to: Routes.page_path(conn, :index))
  #     |> halt()
  #   end
  # end
end
