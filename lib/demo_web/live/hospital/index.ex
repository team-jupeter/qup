defmodule DemoWeb.Hospital.Index do
  use Phoenix.LiveView

  alias Demo.Trade
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
    transactions = Trade.list_transactions(page, per_page)
    assign(socket, transactions: transactions, page_title: "Listing transactions – Page #{page}")
  end

  def handle_info({Trade, [:transaction | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_event("keydown", %{"code" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end
  def handle_event("keydown", %{"code" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end
  def handle_event("keydown", _, socket), do: {:noreply, socket}

  # def handle_event("delete_transaction", %{"id" => id}, socket) do
  #   transaction = Trade.get_transaction!(id)
  #   {:ok, _transaction} = Trade.delete_transaction(transaction)

  #   {:noreply, socket}
  # end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
  end
  defp go_page(socket, _page), do: socket
end
