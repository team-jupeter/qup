defmodule DemoWeb.TradeLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  # alias DemoWeb.TradeLive
  # alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trades
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h2>Show trade</h2>
    <ul>
      <li><b>Product Name:</b> <%= @trade.product %></li>
      <li><b>Price:</b> <%= @trade.price %></li>
      <li><b>Seller:</b> <%= @trade.seller %></li>
      <li><b>Buyer:</b> <%= @trade.buyer %></li>
      <li><b>Where:</b> <%= @trade.where %></li>
    </ul>
    """
  end

  def mount(_params, _session, socket) do
    IO.inspect "TradeLive.Show.mount"
    IO.inspect socket
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Demo.Trades.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, trade: Trades.get_trade!(id))
  end

  def handle_info({Trade, [:trade, :created], _}, socket) do
    {:noreply, fetch(socket)}
  end
end
