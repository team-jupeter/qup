defmodule Demo.Reports.Ledger do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "ledgers" do
    field :buyer_id, :string
    field :invoice_id, :string
    # field :invoice_items, {:array, :map}
    field :item, :string
    field :amount, :decimal
    field :seller_id, :string
    field :quantity, :decimal #? for ABC transaction

    timestamps()
  end

  @fields  [:seller_id, :buyer_id, :amount, :item, :invoice_id, :quantity]
  @doc false
  def changeset(ledger, attrs) do
    ledger
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
