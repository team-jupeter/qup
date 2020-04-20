

defmodule DemoWeb.TradeLive.New do
  use Phoenix.LiveView

  alias DemoWeb.TradeLive
  alias DemoWeb.Router.Helpers, as: Routes
  alias Demo.Trades
  alias Demo.Trades.Trade

  def mount(_params, _session, socket) do
    changeset = Trades.change_trade(%Trade{})

    IO.puts "DemoWeb.TradeLive.New.mount"
    IO.inspect changeset

    IO.puts "socket"
    IO.inspect socket

    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    Phoenix.View.render(DemoWeb.TradeLiveView, "new.html", assigns)
  end

  def handle_event("validate", %{"trade" => trade_params}, socket) do
    changeset =
      %Trade{}
      |> Demo.Trades.change_trade(trade_params)
      |> Map.put(:action, :insert)

    IO.puts "TradeLive.New.handle_event validate"
    IO.inspect changeset

    IO.puts "socket"
    IO.inspect socket

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"trade" => trade_params}, socket) do
    IO.puts "TradeLive.New.handle_event save"
    IO.inspect trade_params
    IO.inspect socket

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
