defmodule DemoWeb.InvoiceLive.PresenceIndex do
  use Phoenix.LiveView

  alias Demo.Users
  alias DemoWeb.{UserLiveView, Presence}
  alias Phoenix.Socket.Broadcast

  def mount(%{"name" => name}, _session, socket) do
    Demo.Users.subscribe()
    Phoenix.PubSub.subscribe(Demo.PubSub, "users")
    Presence.track(self(), "users", name, %{})
    {:ok, fetch(socket)}
  end

  def render(assigns), do: UserLiveView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, %{
      users: Users.list_users(1, 10),
      online_users: DemoWeb.Presence.list("users"),
      page: 0
    })
  end

  def handle_info(%Broadcast{event: "presence_diff"}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Users, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_user", id, socket) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    {:noreply, socket}
  end
end
