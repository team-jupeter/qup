defmodule DemoWeb.Trade.PresenceIndex do
  use Phoenix.LiveView

  alias Demo.Trade
  alias DemoWeb.{TradeView, Presence}
  alias Phoenix.Socket.Broadcast

  def mount(%{"name" => name}, _session, socket) do
    Demo.Trade.subscribe()
    Phoenix.PubSub.subscribe(Demo.PubSub, "transactions")
    Presence.track(self(), "transactions", name, %{})
    {:ok, fetch(socket)}
  end

  def render(assigns), do: TradeView.render("index.html", assigns)

  defp fetch(socket) do
    assign(socket, %{
      transactions: Trade.list_transactions(1, 10),
      online_transactions: DemoWeb.Presence.list("transactions"),
      page: 0
    })
  end

  def handle_info(%Broadcast{event: "presence_diff"}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Trade, [:transaction | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("delete_transaction", id, socket) do
    transaction = Trade.get_transaction!(id)
    {:ok, _transaction} = Trade.delete_transaction(transaction)

    {:noreply, socket}
  end
end
