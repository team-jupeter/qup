defmodule DemoWeb.SessionController do
  use DemoWeb, :controller

  def new(conn, _) do 
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Demo.Accounts.authenticate_by_email_and_pass(email, pass) do
      {:ok, user} ->
        conn
        |> DemoWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.user_path(conn, :show, user.id))

      {:error, _reason} -> 
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> DemoWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
