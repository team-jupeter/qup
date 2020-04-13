defmodule Demo.Trades do

##

  import Ecto.Query, warn: false
  alias Demo.Repo

  # alias Demo.Trade
  alias Demo.Trades.Trade
  # alias Demo.Accounts
  # alias Demo.Accounts.User

  @topic inspect(__MODULE__)



  def subscribe do
    # IO.inspect @topic
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(trade_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{trade_id}")
  end
  # def subscribe(trade_id, listener) do

  #   Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{trade_id}")
  # end


  def list_trades(current_page, per_page) do
    a = Repo.all(
      from t in Trade,
        order_by: [asc: t.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
    IO.inspect a
    a
  end

  def get_trade!(id), do: Repo.get!(Trade, id)

  def create_trade(attrs \\ %{}) do
    IO.puts "Demo.Trades.create_trade"
    IO.puts "attrs"
    IO.inspect attrs

    %Trade{}
    |> Trade.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:trade, :created])
  end


  def change_trade(trade, attrs \\ %{}) do
    Trade.changeset(trade, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    IO.puts "Demo.Trades.notify_subscribers"
    IO.inspect result

    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}

end

