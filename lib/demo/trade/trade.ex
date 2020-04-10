defmodule Demo.Trade do

##

  import Ecto.Query, warn: false
  alias Demo.Repo

  # alias Demo.Trade
  alias Demo.Trade.Transaction
  # alias Demo.Accounts
  # alias Demo.Accounts.User

  @topic inspect(__MODULE__)



  def subscribe do
    # IO.inspect @topic
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(transaction_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{transaction_id}")
  end
  # def subscribe(transaction_id, listener) do

  #   Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{transaction_id}")
  # end


  def list_transactions(current_page, per_page) do
    a = Repo.all(
      from t in Transaction,
        order_by: [asc: t.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
    IO.inspect a
    a
  end

  def get_transaction!(id), do: Repo.get!(Transaction, id)

  def create_transaction(attrs \\ %{}) do
    IO.puts "Demo.Trade.create_transaction"
    IO.puts "attrs"
    IO.inspect attrs

    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:transaction, :created])
  end


  def change_transaction(transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    IO.puts "Demo.Trade.notify_subscribers"
    IO.inspect result

    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}

end

