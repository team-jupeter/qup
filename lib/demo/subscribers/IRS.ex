defmodule Demo.IRS do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Accounts.User


  @topic inspect(__MODULE__)

  def subscribe(transaction_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{transaction_id}")
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:user, :updated])
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
