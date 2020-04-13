defmodule DemoWeb.TradeLive.Index do
  use Phoenix.LiveView

  alias Demo.Trades
  alias DemoWeb.TradeView
  alias DemoWeb.Router.Helpers, as: Routes

  def render(assigns), do: TradeView.render("index.html", assigns)

  def mount(_params, _session, socket) do

    {:ok, assign(socket, page: 1, per_page: 5)}
  end

  def handle_params(params, _url, socket) do
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page, per_page: per_page} = socket.assigns
    trades = Trades.list_trades(page, per_page)
    assign(socket, trades: trades, page_title: "Listing trades – Page #{page}")
  end

  def handle_info({Trade, [:trade | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("keydown", %{"code" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end
  def handle_event("keydown", %{"code" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end
  def handle_event("keydown", _, socket), do: {:noreply, socket}

  # def handle_event("delete_trade", %{"id" => id}, socket) do
  #   trade = Trade.get_trade!(id)
  #   {:ok, _trade} = Trade.delete_trade(trade)

  #   {:noreply, socket}
  # end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
  end
  defp go_page(socket, _page), do: socket
end
