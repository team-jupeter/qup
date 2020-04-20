defmodule DemoWeb.TradeLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias DemoWeb.TradeLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trades
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h2>Show Transaction</h2>
    <ul>
      <li><b>Transaction ID:</b> <%= @trade.id %></li>
      <li><b>Product:</b> <%= @trade.dummy_product %></li>
      <li><b>Buyer:</b> <%= @trade.dummy_buyer %></li>
      <li><b>Seller:</b> <%= @trade.dummy_seller %></li>

    </ul>
    <span><%= link "Edit", to: Routes.live_path(@socket, TradeLive.Edit, @trade) %></span>
    <span><%= link "Back", to: Routes.live_path(@socket, TradeLive.Index) %></span>
    """
  end

  def mount(_params, _session, socket) do
    # IO.inspect "socket"
    # IO.inspect socket
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Demo.Trades.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    IO.inspect Trades.get_trade!(id)
    assign(socket, trade: Trades.get_trade!(id))
  end

  def handle_info({Trades, [:trade, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Trades, [:trade, :deleted], _}, socket) do
    {:stop,
     socket
     |> put_flash(:error, "This trade has been deleted from the system")
     |> redirect(to: Routes.live_path(socket, TradeLive.Index))}
  end
end
