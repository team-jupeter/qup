defmodule DemoWeb.Trade.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias DemoWeb.Trade
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trade
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h2>Show transaction</h2>
    <ul>
      <li><b>Name:</b> <%= @transaction.name %></li>
      <li><b>Transaction:</b> <%= @transaction.transaction %></li>
      <li><b>Email:</b> <%= @transaction.email %></li>
      <li><b>Phone:</b> <%= @transaction.phone_number %></li>
    </ul>
    <span><%= link "Edit", to: Routes.live_path(@socket, TradeLive.Edit, @transaction) %></span>
    <span><%= link "Back", to: Routes.live_path(@socket, TradeLive.Index) %></span>
    """
  end

  def mount(_params, _session, socket) do
    IO.inspect "socket"
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

  def handle_info({Trade, [:transaction, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Trade, [:transaction, :deleted], _}, socket) do
    {:stop,
     socket
     |> put_flash(:error, "This transaction has been deleted from the system")
     |> redirect(to: Routes.live_path(socket, TradeLive.Index))}
  end
end
