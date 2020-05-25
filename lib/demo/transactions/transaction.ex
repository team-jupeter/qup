defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do

    #? previous transaction_id and digital signature of invoice
    field :hash_of_invoice, :string

    #? who pays ABC? which t1s in his/her/its wallet?
    field :abc_input, :string #? public_address of buyer. 
    field :abc_output, :string #? public_address of buyer. 
    field :abc_input_t1s, {:array, :map}, default: []
    field :abc_amount, :decimal, precision: 15, scale: 4
    field :items, {:array, :map}

    #? locking script and conditions of spending moneny by recipient.
    # field :locked, :boolean, default: false
    # field :locking_use_area, {:array, :string}, default: []
    # field :locking_use_until, :naive_datetime
    # field :locking_output_entity_catetory, {:array, :string}, default: []
    # field :locking_output_specific_entities, {:array, :string}, default: []
    
    # embeds_one :buyer, Demo.Invoices.BuyerEmbed, on_replace: :update
    # embeds_one :seller, Demo.Invoices.SellerEmbed, on_replace: :update
    # embeds_many :payments, Demo.Invoices.Payment, on_replace: :raise

    has_one :invoice, Demo.Invoices.Invoice, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs \\ %{}) do
    transaction
    |> cast(attrs, [])
    |> validate_required([])
    |> check_fair_trade
  end

  defp check_fair_trade(txn_cs) do
    #? check the fairness of the transaction
    txn_cs
  end
end
