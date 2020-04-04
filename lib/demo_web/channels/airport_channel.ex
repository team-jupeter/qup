# Presence, PubSub
defmodule DemoWeb.AirportChannel do
  use DemoWeb, :channel

  alias Demo.Accounts

  def join("airports:" <> user_name, _params, socket) do
    send(self(), :after_join)
    user_name = String.to_integer(user_name)
    airport = Accounts.get_user!(user_name)

    {:ok, assign(socket, :airport, airport)}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", DemoWeb.Presence.list(socket))
    {:ok, _} = DemoWeb.Presence.track(socket, socket.assigns.user_id, %{device: "browser"})
    {:noreply, socket}
  end


  def handle_in(event, params, socket) do
    user = Accounts.get_user!(socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_in("new_passenger", params, user, socket) do
    case Accounts.inform_airport(user, socket.assigns.airport, params) do
      {:ok, passenger} ->
        broadcast!(socket, "new_passenger", %{
          id: passenger.id,
          user: DemoWeb.UserView.render("user.json", %{user: user}),
          body: passenger.info, # passenger information
          from: passenger.from # departure airport
        })
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
