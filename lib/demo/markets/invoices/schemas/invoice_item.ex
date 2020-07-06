defmodule Demo.Invoices.InvoiceItem do
  use Ecto.Schema 
  import Ecto.Changeset
  alias Demo.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "invoice_items" do
    field :item_name, :string
    field :price, :decimal, precision: 16, scale: 6
 
    field :buyer_id, :binary_id

    field :seller_id, :binary_id
    field :seller_name, :string
    field :seller_supul_id, :binary_id
    field :seller_supul_name, :string
    
    field :quantity, :decimal, precision: 12, scale: 2
    field :tax_subtotal, :decimal, precision: 16, scale: 6, default: 0.0
    field :subtotal, :decimal, precision: 16, scale: 6, default: 0.0
     
    belongs_to :entity, Demo.Business.Entity, type: :binary_id
    belongs_to :product, Demo.Business.Product, type: :binary_id
    belongs_to :invoice, Demo.Invoices.Invoice, type: :binary_id

    timestamps()
  end

  @fields [
    :item_name, :price, :product_id, :quantity, 
    :tax_subtotal, :subtotal, :entity_id, 
    :seller_id, :buyer_id
  ]
  # @zero Decimal.new(0)

  def changeset(data, params \\ %{}) do
    IO.inspect params
    data
    |> cast(params, @fields)
    |> validate_required([])
    # |> validate_number(greater_than_or_equal_to: @zero)
    # |> validate_number(:quantity, greater_than_or_equal_to: @zero)
    # |> foreign_key_constraint(:invoice_id, message: "Select a valid invoice")
    |> set_subtotal
    |> IO.inspect
    # |> IO.inspect
  end

  def set_subtotal(cs) do
    case {(cs.changes[:price] || cs.data.price), (cs.changes[:quantity] || cs.data.quantity)} do
      {_price, nil} -> cs
      {nil, _quantity} -> cs
      {price, quantity} ->
        put_change(cs, :subtotal, Decimal.mult(price, quantity))

    end
  end
end
