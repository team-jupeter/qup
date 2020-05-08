defmodule Demo.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Ecto.Changeset
  alias Demo.Repo
  alias Demo.Invoices.{Item, Invoice, InvoiceItem}
  alias Demo.Entities.Entity
  # alias Demo.Entities.Entity

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "invoices" do
    field :start_at, :date
    field :end_at, :date
    field :amount, :decimal, precision: 12, scale: 2
    field :balance, :decimal, precision: 12, scale: 2

    has_many :invoice_items, InvoiceItem, on_delete: :delete_all

    embeds_one :buyer, Demo.Invoices.BuyerEmbed, on_replace: :update
    embeds_one :seller, Demo.Invoices.SellerEmbed, on_replace: :update

    # embeds_many :products, Demo.Products.ProductEmbed, on_replace: :delete #? has_many
    # #? has_one :permalink, Permalink

    many_to_many(
      :entities,
      Demo.Entities.Entity,
      join_through: "entities_invoices",
      on_replace: :delete
      )

    timestamps()
  end


  @fields [:amount, :balance]

  def changeset(data, params \\ %{}) do
    # IO.puts "changeset"
    IO.inspect "params"
    IO.inspect params
    data
    # |> IO.inspect
    |> cast(params, @fields)
    |> cast_embed(:buyer)
    |> IO.inspect
    |> cast_embed(:seller)
    |> IO.inspect
    # |> IO.inspect
    # |> validate_required([:buyer])
  end

  def create(params) do
    IO.puts "create"
    changeset(%Invoice{}, params)
    |> validate_item_count(params)
    |> put_assoc(:invoice_items, get_items(params))
    # |> put_assoc(:entities, Entity.changeset(params[:buyer]))
    |> IO.inspect
    |> Repo.insert
  end

  defp get_items(params) do
    IO.puts "get_items"
    IO.inspect params

    items = items_with_prices(params[:invoice_items] || params["invoice_items"])

    IO.inspect "items"
    IO.inspect items

    Enum.map(items, fn(item)-> InvoiceItem.changeset(%InvoiceItem{}, item) end)
  end


  defp items_with_prices(items) do
    IO.puts "items_with_prices"

    item_ids = Enum.map(items, fn(item) -> item[:item_id] || item["item_id"] end)

    # q = from("items", where: id: in ^item_ids, select: [:id, :price])
    q = from(i in Item, select: %{id: i.id, price: i.price}, where: i.id in ^item_ids)

    prices = Repo.all(q)

    IO.puts "show item_id and prices"
    IO.inspect prices

    IO.puts "return item_id, quantity, and prices"
    Enum.map(items, fn(item) ->
      item_id = item[:item_id] || item["item_id"]
      a = %{
         item_id: item_id,
         quantity: item[:quantity] || item["quantity"],
         price: Enum.find(prices, fn(p) -> p[:id] == item_id end)[:price] || 0
       }
      IO.puts "a"
      IO.inspect a
      a
    end)
  end

  defp validate_item_count(cs, params) do
    items = params[:invoice_items] || params["invoice_items"]

    if Enum.count(items) <= 0 do
      add_error(cs, :invoice_items, "Invalid number of items")
    else
      cs
    end
  end

end
