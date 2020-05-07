defmodule DemoWeb.Aviation.New do
  use Phoenix.LiveView

  # alias DemoWeb.Aviation
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Users
  alias Demo.Users.User

  def mount(_params, _session, socket) do
    changeset = Users.change_user(%User{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(DemoWeb.UserView, "new.html", assigns)

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> Demo.Users.change_user(user_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        {:noreply,
         socket
         |> put_flash(:info, "user created")
         |> redirect(to: Routes.live_path(socket, AviationView.Show, user))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
