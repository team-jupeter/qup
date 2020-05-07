defmodule DemoWeb.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # IO.puts "call"
    # IO.inspect conn
    user_id = get_session(conn, :user_id)
    user = user_id && Demo.Users.get_user(user_id)
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
    # |> IO.inspect
  end

  def logout(conn) do
    # IO.puts "logout"
    # IO.inspect conn
    configure_session(conn, drop: true) # initialize conn
  end
end
