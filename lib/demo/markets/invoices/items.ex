defmodule Demo.Items do
    import Ecto.Query, warn: false
    alias Demo.Repo
    alias Demo.Invoices.Item

    @topic inspect(__MODULE__)


    def subscribe do
      Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
    end

    def subscribe(item_id) do
      Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{item_id}")
    end

    def list_items, do: Repo.all(Item)

    def list_items(current_page, per_page) do
      Repo.all(
        from u in Item,
          order_by: [asc: u.id],
          offset: ^((current_page - 1) * per_page),
          limit: ^per_page
      )
    end

    def get_item!(id), do: Repo.get!(Item, id)

    def change_item(item, attrs \\ %{}) do
      Item.changeset(item, attrs)
    end

    def create_item(attrs \\ %{}) do
    %Item{}
      |> Item.changeset(attrs)
      |> Repo.insert()
      |> notify_subscribers([:item, :created])
    end

    def delete_item(%Item{} = item) do
      Repo.delete(item)
    end 

    def update_item(%Item{} = item, attrs) do
      item
      |> Item.changeset(attrs)
      |> Repo.update()
    end
    # import Ecto.Changeset, only: [change: 2]

    # buyer = Repo.get!(Entity, 2)
    # seller = Repo.get!(Entity, 1)
    # price = 1

    # Repo.transaction(fn ->
    #   Repo.update!(change(buyer, balance: buyer.balance - 10))
    #   Repo.update!(change(seller, balance: seller.balance + 10))
    # end)


    defp notify_subscribers({:ok, result}, event) do
      Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
      Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
      {:ok, result}
    end

    defp notify_subscribers({:error, reason}, _event), do: {:error, reason}

  end

