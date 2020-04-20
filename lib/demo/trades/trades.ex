defmodule Demo.Trades do

##

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.Trades.Trade

  @topic inspect(__MODULE__)


  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(trade_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{trade_id}")
  end

  def list_trades, do: Repo.all(Trade)

  def list_trades(current_page, per_page) do
    Repo.all( 
      from u in Trade,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  def get_trade!(id), do: Repo.get!(Trade, id)

  def change_trade(trade, attrs \\ %{}) do
    Trade.changeset(trade, attrs)
  end

  def create_trade(attrs \\ %{}) do
  %Trade{}
    |> Trade.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:trade, :created])
  end


  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}

end

