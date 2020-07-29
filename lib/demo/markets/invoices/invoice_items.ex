defmodule Demo.InvoiceItems do
    import Ecto.Query, warn: false
    alias Demo.Repo
    alias Demo.Invoices.InvoiceItem
    alias Demo.Entities.Entity

    import Ecto.Query, only: [from: 2]

    @topic inspect(__MODULE__)


    def subscribe do
      Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
    end

    def subscribe(invoice_item_id) do
      Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{invoice_item_id}")
    end 

    def list_invoice_items(buyer_id) do 
      Repo.all(
        from u in InvoiceItem,
          where: u.buyer_id == ^buyer_id
      ) 
    end

    def list_invoice_items(current_page, per_page) do
      Repo.all(
        from u in InvoiceItem,
          order_by: [asc: u.id],
          offset: ^((current_page - 1) * per_page),
          limit: ^per_page
      )
    end

    def get_invoice_item!(id), do: Repo.get!(InvoiceItem, id)


    def change_invoice_item(invoice_item, attrs \\ %{}) do      
      InvoiceItem.changeset(invoice_item, attrs)
    end

    def create_invoice_item(attrs) do 
     %InvoiceItem{}
      |> InvoiceItem.changeset(attrs)
      |> Repo.insert()
      # |> notify_subscribers([:invoice_item, :created])
    end

    def delete_invoice_item(%InvoiceItem{} = invoice_item) do
      IO.puts "delete_invoice_item"
      Repo.delete(invoice_item)
    end 

    def update_invoice_item(%InvoiceItem{} = invoice_item, attrs) do
      IO.puts "update_invoice_item"
      invoice_item
      |> InvoiceItem.changeset(attrs)
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

