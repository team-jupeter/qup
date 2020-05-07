defmodule Demo.Invoices do
    import Ecto.Query, warn: false
    alias Demo.Repo
    alias Demo.Invoices.Invoice

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

    def get_invoice!(id), do: Repo.get!(Invoice, id)

    def change_invoice(invoice, attrs \\ %{}) do
      Invoice.changeset(invoice, attrs)
    end

    def create_invoice(attrs \\ %{}) do
    %Invoice{}
      |> Invoice.changeset(attrs)
      |> Repo.insert()
      |> notify_subscribers([:invoice, :created])
    end

    import Ecto.Query
    def running_invoices(start_at, end_at) do
      query =
      from e in "entities",
        join: i in "invoices",
        on: i.entity_id == e.id,
        where: i.start_at > type(^start_at, :naive_datetime) and
          i.end_at < type(^end_at, :naive_datetime),
        group_by: i.entity_id,
        select: %{
          entity_id: i.entity_id,
          interval: i.end_at - i.start_at,
          count: count(e.id)
        }
      Demo.Repo.all(query)
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

