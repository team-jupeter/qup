defmodule DemoWeb.Trade.Edit do
  use Phoenix.LiveView

  alias DemoWeb.Trade
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trade

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    transaction = Trade.get_transaction!(id)
    {:noreply,
     assign(socket, %{
       transaction: transaction,
       changeset: Trade.change_transaction(transaction)
     })}
  end

  def render(assigns), do: DemoWeb.TradeView.render("edit.html", assigns)

  def handle_event("validate", %{"transaction" => params}, socket) do
    changeset =
      socket.assigns.transaction
      |> Demo.Trade.change_transaction(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"transaction" => transaction_params}, socket) do
    case Trade.update_transaction(socket.assigns.transaction, transaction_params) do
      {:ok, transaction} ->
        {:noreply,
         socket
         |> put_flash(:info, "transaction updated successfully.")
         |> redirect(to: Routes.live_path(socket, Trade.Show, transaction))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
