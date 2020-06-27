defmodule Demo.Items do
    import Ecto.Query, warn: false
  
    alias Demo.Invoices.InvoiceItem
    alias Demo.Invoices.Item
    alias Demo.Repo
  
   
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

    def items_by_quantity, do: Repo.all items_by(:quantity)

    def items_by_subtotal, do: Repo.all items_by(:subtotal)
  
    defp items_by(type) do
      from i in Item,
      join: ii in InvoiceItem, on: ii.item_id == i.id,
      select: %{id: i.id, name: i.name, total: sum(field(ii, ^type))},
      group_by: i.id,
      order_by: [desc: sum(field(ii, ^type))]
    end
    # defp items_by(type) do
    #   Item
    #   |> join(:inner, [i], ii in InvoiceItem, ii.item_id == i.id)
    #   |> select([i, ii], %{id: i.id, name: i.name, total: sum(field(ii, ^type))})
    #   |> group_by([i, _], i.id)
    #   |> order_by([_, ii], [desc: sum(field(ii, ^type))])
    # end
  

    defp notify_subscribers({:ok, result}, event) do
      Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
      Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
      {:ok, result}
    end

    defp notify_subscribers({:error, reason}, _event), do: {:error, reason}

  end

