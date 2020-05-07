defmodule DemoWeb.InvoiceLive.Row do
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
    <tr class="invoice-row" id="<%= @id %>" phx-click="click" phx-target="#<%= @id %>">
      <td><%= @invoice.id %></td>
      <td>
        <%= live_component @socket, Product, id: "product-#{@id}", product: @invoice.product_id %>
      </td>
      <td>
        <%= live_component @socket, Buyer, id: "buyer-#{@id}", buyer: @invoice.buyer_id %>
      </td>
      <td>
        <%= live_component @socket, Seller, id: "seller-#{@id}", seller_id: @invoice.seller_id %>
      </td>
    </tr>
    """
  end

  # def handle_event("click", _, socket) do
  #   {:noreply, update(socket, :count, &(&1 + 1))}
  # end
end

defmodule DemoWeb.InvoiceLive.Index do
  use Phoenix.LiveView

  alias DemoWeb.InvoiceLive.Row

  def render(assigns) do
    IO.puts "render"
    IO.inspect assigns

    ~L"""
    <table>
      <tbody id="invoices"
             phx-update="append"
             phx-hook="InfiniteScroll"
             data-page="<%= @page %>">
        <%= for invoice <- @invoices do %>
          <%= live_component @socket, Row, id: "invoice-#{invoice.id}", invoice: invoice %>
        <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    IO.puts "index.mount"
    IO.inspect socket

    if connected?(socket), do: Demo.Invoices.subscribe()

    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [invoices: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, invoices: Demo.Invoices.list_invoices(page, per))
  end

  def handle_info({Invoices, [:invoice | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
