defmodule Demo.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Repo
  alias Demo.Invoices.Invoice

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :start_at, :naive_datetime
    field :end_at, :naive_datetime
    field :total, :decimal, precision: 12, scale: 2
    field :tax_total, :decimal, precision: 5, scale: 2
    field :fiat_currency, :decimal, precision: 12, scale: 2

    has_many :invoice_items, Demo.Invoices.InvoiceItem, on_delete: :delete_all
    belongs_to :transaction, Demo.Transactions.Transaction, type: :binary_id

    embeds_one :buyer, Demo.Invoices.BuyerEmbed, on_replace: :delete
    embeds_one :seller, Demo.Invoices.SellerEmbed, on_replace: :delete
    embeds_many :payments, Demo.Invoices.Payment, on_replace: :delete

    many_to_many(
      :entities,
      Demo.Business.Entity,
      join_through: "entities_invoices",
      on_replace: :delete
      )

    timestamps()
  end


  @fields [:total, :start_at, :end_at, :tax_total, :fiat_currency]

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> cast_embed(:buyer)
    |> cast_embed(:seller)
  end


  def create(params) do
    changeset(%Invoice{}, params)
    |> put_assoc(:invoice_items, params["invoice_items"])
    |> Repo.insert #? {ok, invoice}
    |> add_total
  end


  defp add_total({_ok, invoice}) do
    total = Enum.reduce(invoice.invoice_items, 0, fn x, sum -> Decimal.add(x.subtotal, sum) end)
    
    #? When we change a struct, change => put_change => update
    invoice 
    |> change 
    |> put_change(:total, total) 
    |> Repo.update
  end




  # defp get_items(params) do
  #   IO.puts "get items"
  #   items = items_with_prices(params[:invoice_items] || params["invoice_items"])
  #   Enum.map(items, fn(item)-> InvoiceItem.changeset(%InvoiceItem{}, item) end)
  # end


  # defp items_with_prices(items) do
  #   item_ids = Enum.map(items, fn(item) -> item[:item_id] || item["item_id"] end)
  #   q = from(i in Item, select: %{id: i.id, price: i.price}, where: i.id in ^item_ids)

  #   prices = Repo.all(q)

  #   Enum.map(items, fn(item) ->
  #     item_id = item[:item_id] || item["item_id"]
  #     %{
  #        item_id: item_id,
  #        quantity: item[:quantity] || item["quantity"],
  #        price: Enum.find(prices, fn(p) -> p[:id] == item_id end)[:price] || 0
  #      }
  #   end)
  # end

  # defp validate_item_count(cs, params) do
  #   items = params[:invoice_items] || params["invoice_items"]

  #   if Enum.count(items) <= 0 do
  #     add_error(cs, :invoice_items, "Invalid number of items")
  #   else
  #     cs
  #   end
  # end


end
