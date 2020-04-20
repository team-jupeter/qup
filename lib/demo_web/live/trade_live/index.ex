defmodule DemoWeb.TradeLive.Row do
  use Phoenix.LiveComponent

  defmodule Product do
    use Phoenix.LiveComponent

    def mount(socket) do
      IO.inspect socket

      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Product: <%= @product_id %>
      </span>
      """
    end
  end

  defmodule Buyer do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Buyer: <%= @buyer_id %>
      </span>
      """
    end
  end
  defmodule Seller do
    use Phoenix.LiveComponent

    def mount(socket) do
      {:ok, socket}
    end

    def render(assigns) do
      ~L"""
      <span id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>" phx-hook="Test">
        Seller: <%= @seller_id %>
      </span>
      """
    end
  end

  def mount(socket) do
    IO.puts "Row.mount"
    IO.inspect socket

    {:ok, assign(socket, product_id: 1, buyer_id: 2, seller_id: 3)}
  end

  def render(assigns) do
    IO.puts "Row.render"
    IO.inspect assigns

    ~L"""
    <tr class="trade-row" id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>">
      <td><%= @trade.id %></td>
      <td><%= @trade.dummy_product %></td>
      <td><%= @trade.dummy_buyer %></td>
      <td><%= @trade.dummy_seller %></td>
      <td>
        <%= live_component @socket, Product, id: "product-#{@id}", product: @trade.product_id %>
      </td>
      <td>
        <%= live_component @socket, Buyer, id: "buyer-#{@id}", buyer: @trade.buyer_id %>
      </td>
      <td>
        <%= live_component @socket, Seller, id: "seller-#{@id}", seller_id: @trade.seller_id %>
      </td>
    </tr>
    """
  end

  # def handle_event("click", _, socket) do
  #   {:noreply, update(socket, :count, &(&1 + 1))}
  # end
end

defmodule DemoWeb.TradeLive.Index do
  use Phoenix.LiveView

  alias DemoWeb.TradeLive.Row

  def render(assigns) do
    IO.puts "render"
    IO.inspect assigns

    ~L"""
    <table>
      <tbody id="trades"
             phx-update="append"
             phx-hook="InfiniteScroll"
             data-page="<%= @page %>">
        <%= for trade <- @trades do %>
          <%= live_component @socket, Row, id: "trade-#{trade.id}", trade: trade %>
        <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    IO.puts "index.mount"
    IO.inspect socket

    if connected?(socket), do: Demo.Trades.subscribe()

    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [trades: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, trades: Demo.Trades.list_trades(page, per))
  end

  def handle_info({Trades, [:trade | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
