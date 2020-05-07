defmodule DemoWeb.UserLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias DemoWeb.UserLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Users
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h2>Show User</h2>
    <ul>
      <li><b>ID:</b> <%= @user.id %></li>
      <li><b>Type:</b> <%= @user.type %></li>
      <li><b>Name:</b> <%= @user.name %></li>
      <li><b>Email:</b> <%= @user.email %></li>
      <li><b>Balance:</b> <%= @user.balance %></li>
    </ul>
    <span><%= link "Edit", to: Routes.live_path(@socket, UserLive.Edit, @user) %></span>
    <span><%= link "Back", to: Routes.live_path(@socket, UserLive.Index) %></span>
    """
  end

  def mount(_params, _session, socket) do
    # IO.inspect "socket"
    # IO.inspect socket
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Demo.Users.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    IO.inspect Users.get_user!(id)
    assign(socket, user: Users.get_user!(id))
  end

  def handle_info({Users, [:user, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Users, [:user, :deleted], _}, socket) do
    {:stop,
     socket
     |> put_flash(:error, "This user has been deleted from the system")
     |> redirect(to: Routes.live_path(socket, UserLive.Index))}
  end
end
