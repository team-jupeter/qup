defmodule DemoWeb.TradeLive.New do
  use Phoenix.LiveView

  alias DemoWeb.TradeLive
  alias DemoWeb.Router.Helpers, as: Routes
  # alias Demo.Trades
  alias Demo.Trades
  alias Demo.Trades.Trade

  def mount(_params, _session, socket) do
    IO.puts("Trades.mount")
    IO.inspect(socket)

    changeset = Trades.change_trade(%Trade{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(DemoWeb.TradeView, "new.html", assigns)

  def handle_event("validate", %{"trade" => trade_params}, socket) do
    changeset =
      %Trade{}
      |> Demo.Trades.change_trade(trade_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"trade" => trade_params}, socket) do
    IO.puts("save called")
    IO.inspect(trade_params)
    IO.inspect(socket)

    case Trades.create_trade(trade_params) do
      {:ok, trade} ->
        {:noreply,
         socket
         |> put_flash(:info, "trade created")
         |> redirect(to: Routes.live_path(socket, TradeLive.Show, trade))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
