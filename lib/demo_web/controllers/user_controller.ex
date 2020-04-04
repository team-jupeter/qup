# defmodule DemoWeb.UserController do
#   use DemoWeb, :controller

#   alias Demo.Accounts
#   alias Demo.Accounts.User

#   plug :authenticate when action in [:index, :show]


#   def index(conn, _params) do
#     # IO.inspect conn
#     users = Accounts.list_users()
#     # IO.inspect conn
#     render(conn, "index.html", users: users)
#   end

#   def show(conn, %{"id" => id}) do
#     # IO.inspect conn
#     user = Accounts.get_user(id)
#     # IO.inspect conn
#     render(conn, "show.html", user: user)
#   end

#   def new(conn, _params) do
#     # IO.inspect conn
#     changeset = Accounts.change_user(%User{})
#     # IO.inspect conn
#     render(conn, "new.html", changeset: changeset)
#   end

#   def create(conn, %{"user" => user_params}) do
#     case Accounts.register_user(user_params) do
#       {:ok, user} ->
#         conn
#         |> DemoWeb.Auth.login(user)
#         |> put_flash(:info, "#{user.name} created!")
#         |> redirect(to: Routes.user_path(conn, :index))

#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "new.html", changeset: changeset)
#     end
#   end

#   defp authenticate(conn, _opts) do
#     if conn.assigns.current_user do
#       conn
#     else
#       conn
#       |> put_flash(:error, "You must be logged in to access that page")
#       |> redirect(to: Routes.page_path(conn, :index))
#       |> halt()
#     end
#   end
# end
