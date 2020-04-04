defmodule DemoWeb.Trade.New do
  use Phoenix.LiveView

  alias DemoWeb.Trade
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trade
  alias Demo.Trade.Transaction

  def mount(_params, _session, socket) do
    changeset = Trade.change_transaction(%Transaction{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(DemoWeb.TradeView, "new.html", assigns)

  def handle_event("validate", %{"transaction" => transaction_params}, socket) do
    changeset =
      %Transaction{}
      |> Demo.Trade.change_transaction(transaction_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"transaction" => transaction_params}, socket) do
    case Trade.create_transaction(transaction_params) do
      {:ok, transaction} ->
        {:noreply,
         socket
         |> put_flash(:info, "transaction created")
         |> redirect(to: Routes.live_path(socket, TradeLive.Show, transaction))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
