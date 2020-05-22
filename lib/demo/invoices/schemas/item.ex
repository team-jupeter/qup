defmodule Demo.Invoices.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Demo.Invoices.InvoiceItem
  alias Demo.Invoices.Item
  alias Demo.Repo
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "items" do
    field :gpc_code, :string 
    field :category, :string
    field :name, :string
    field :price, :decimal, precision: 12, scale: 2
    field :product_uuid, :string
    field :document, :string
    field :document_hash, :string
    # field :tax_rate, :integer, precision: 5, scale: 2

    field :input_tx, :string
    field :output_to, :string
    field :output_ratio, :decimal, precision: 12, scale: 2, default: 100.0

    field :locking_use_area, {:array, :string}, default: []
    field :locking_use_until, :naive_datetime
    field :locking_output_to_entity_catetory, :naive_datetime
    field :locking_output_to_specific_entities, {:array, :string}, default: []

    has_many :invoice_items, InvoiceItem

    timestamps()
  end

  @fields [:gpc_code, :category, :name, :price]

  def changeset(data, params \\ %{}) do
    # IO.puts "Demo.Invoices.Item changeset"
    # IO.inspect data
    # IO.inspect params

    data
    |> cast(params, @fields)
    # |> validate_required(@fields)
    |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
  end

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
end
