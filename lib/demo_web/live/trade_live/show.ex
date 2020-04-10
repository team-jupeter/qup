defmodule DemoWeb.TradeLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias DemoWeb.TradeLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trade
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h2>Show transaction</h2>
    <ul>
      <li><b>Product Name:</b> <%= @transaction.product %></li>
      <li><b>Price:</b> <%= @transaction.price %></li>
      <li><b>Seller:</b> <%= @transaction.seller %></li>
      <li><b>Buyer:</b> <%= @transaction.buyer %></li>
      <li><b>Where:</b> <%= @transaction.where %></li>
    </ul>
    """
  end

  def mount(_params, _session, socket) do
    IO.inspect "TradeLive.Show.mount"
    IO.inspect socket
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Demo.Trade.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, transaction: Trade.get_transaction!(id))
  end

  def handle_info({Trade, [:transaction, :created], _}, socket) do
    {:noreply, fetch(socket)}
  end
end
