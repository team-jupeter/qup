defmodule DemoWeb.InvoiceLive.Show do
  use Phoenix.LiveView
  use Phoenix.HTML

  alias DemoWeb.InvoiceLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Invoices
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~L"""
    <h2>Show Transaction</h2>
    <ul>
      <li><b>Transaction ID:</b> <%= @invoice.id %></li>
    </ul>
    <span><%= link "Edit", to: Routes.live_path(@socket, InvoiceLive.Edit, @invoice) %></span>
    <span><%= link "Back", to: Routes.live_path(@socket, InvoiceLive.Index) %></span>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Demo.Invoices.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, invoice: Invoices.get_invoice!(id))
  end

  def handle_info({Invoices, [:invoice, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Invoices, [:invoice, :deleted], _}, socket) do
    {:stop,
     socket
     |> put_flash(:error, "This invoice has been deleted from the system")
     |> redirect(to: Routes.live_path(socket, InvoiceLive.Index))}
  end
end
