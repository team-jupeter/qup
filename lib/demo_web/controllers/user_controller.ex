defmodule DemoWeb.UserController do
  use DemoWeb, :controller

  alias Demo.Accounts
  alias Demo.Accounts.User

  plug :authenticate_user when action in [:index, :show, :edit]


  def index(conn, _params) do
    IO.puts "user index"
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end
 
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do 
    case Accounts.register_user(user_params) do
      {:ok, user} -> 
        conn
        |> DemoWeb.Auth.login(user)
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


  def edit(conn, %{"id" => id}) do
    user = User |> Demo.Repo.get!(id) 
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = User |> Demo.Repo.get!(id) 

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        # |> redirect(to: Routes.user_path(conn, :show, user))
        render(conn, "show.html", user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

end
