

defmodule DemoWeb.InvoiceLive.New do
  use Phoenix.LiveView

  alias DemoWeb.InvoiceLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Invoices
  alias Demo.Invoices.Invoice

  def mount(_params, _session, socket) do
    changeset = Invoices.change_invoice(%Invoice{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    Phoenix.View.render(DemoWeb.InvoiceLiveView, "new.html", assigns)
  end

  def handle_event("validate", %{"invoice" => invoice_params}, socket) do
    changeset =
      %Invoice{}
      |> Demo.Invoices.change_invoice(invoice_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"invoice" => invoice_params}, socket) do
    case Invoices.create_invoice(invoice_params) do
      {:ok, invoice} ->
        {:noreply,
         socket
         |> put_flash(:info, "invoice created")
         |> redirect(to: Routes.live_path(socket, InvoiceLive.Show, invoice))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
