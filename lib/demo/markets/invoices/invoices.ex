defmodule Demo.Invoices do
    import Ecto.Query, warn: false
    alias Demo.Repo
    alias Demo.Invoices.Invoice
    # alias Demo.Transactions

    @topic inspect(__MODULE__)

 
    def subscribe do
      Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
    end

    def subscribe(invoice_id) do
      Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{invoice_id}")
    end

    def list_invoices, do: Repo.all(Invoice)

    def list_invoices(current_page, per_page) do
      Repo.all(
        from u in Invoice,
          order_by: [asc: u.id],
          offset: ^((current_page - 1) * per_page),
          limit: ^per_page
      )
    end

    def list_buyer_invoices(buyer_id) do 
      Repo.all(
        from u in Invoice,
          where: u.buyer_id == ^buyer_id
      )
    end

    def get_invoice!(id), do: Repo.get!(Invoice, id)


    def change_invoice(invoice, attrs \\ %{}) do
      Invoice.changeset(invoice, attrs) 
    end

    def create_invoice(attrs) do
      %Invoice{}
      |> Invoice.create(attrs)
      # |> notify_subscribers([:transaction, :created])
    
    end 

    def delete_invoice(%Invoice{} = invoice) do
      Repo.delete(invoice)
    end 

    def update_invoice(%Invoice{} = invoice, attrs) do
      invoice
      |> Invoice.changeset(attrs)
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

