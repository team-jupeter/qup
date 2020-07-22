defmodule Demo.Invoices.Item do
  import Ecto.Changeset
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "items" do
    field :name, :string
    field :price, :decimal, precision: 15, scale: 4
    field :document, :string
    field :document_hash, :string
    # field :tax_rate, :integer, precision: 5, scale: 2
    
    # embeds_one :item_locker, Demo.Invoices.ItemLockeEmbed
    
    belongs_to :product, Demo.Entities.Product, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    # has_one :invoice_item, Demo.Invoices.InvoiceItem
 
    timestamps()
  end

  @fields [
    :name, :product_id, :price, :document, :document_hash
  ]

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required([])
    # |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
  end

end
