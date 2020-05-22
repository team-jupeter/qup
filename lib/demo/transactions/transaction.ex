defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do

    #? previous transaction_id and index_no
    field :input_from, :string
    field :input_t1s, {:array, :map}, default: []

    #? recipient or seller's public key and payment amount
    field :output_to, :string
    field :output_amount, :decimal, precision: 12, scale: 2

    #? locking script and conditions of spending moneny by recipient.
    field :locked, :boolean, default: false
    field :locking_use_area, {:array, :string}, default: []
    field :locking_use_until, :naive_datetime
    field :locking_output_to_entity_catetory, {:array, :string}, default: []
    field :locking_output_to_specific_entities, {:array, :string}, default: []
    
    # embeds_one :buyer, Demo.Invoices.BuyerEmbed, on_replace: :update
    # embeds_one :seller, Demo.Invoices.SellerEmbed, on_replace: :update
    # embeds_many :payments, Demo.Invoices.Payment, on_replace: :raise

    belongs_to :ledger, Demo.Reports.Ledger, type: :binary_id
    has_many :invoices, Demo.Invoices.Invoice, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs \\ %{}) do
    transaction
    |> cast(attrs, [])
    |> validate_required([])
  end
end
