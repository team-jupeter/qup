defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do

    #? previous transaction_id and digital signature of invoice
    field :hash_of_invoice, :string

    #? who pays ABC? which t1s in his/her/its wallet?
    field :buyer, :binary_id #? entity_id. 
    field :seller, :binary_id #? entity_id. 
    field :abc_input, :string #? public_address of buyer. 
    field :abc_output, :string #? public_address of buyer. 
    field :abc_input_t1s, {:array, :map}, default: []
    field :abc_amount, :decimal, precision: 15, scale: 4
    field :items, {:array, :binary_id}
    field :fiat_currency, :decimal, precision: 15, scale: 4
    field :transaction_status, :string, default: "processing" #? processing, pending, completed
    field :if_only_item, :string 
    field :fair?, :boolean, default: false
    
    has_one :invoice, Demo.Invoices.Invoice, on_delete: :delete_all
    has_one :ticket, Demo.Tickets.Ticket, on_delete: :delete_all

    belongs_to :taxation, Demo.Taxations.Taxation
    
    timestamps()
  end

  @doc false
  def changeset(transaction, attrs \\ %{}) do
    transaction
    |> cast(attrs, [])
    |> validate_required([])
    # |> check_fair_trade(attrs)
  end

  # defp check_fair_trade(transaction_cs, attrs \\ %{}) do
  #   #? check the fairness of the transaction
  #   # market_value = average_market_value(attrs.item_id)
  #   transaction_cs
  # end

  # defp average_market_value(attrs.item) do
  #   market_value = 4
  #   case market_value * 0.8 < item.price < market_value * 1.2 do:
  #     true -> fair? = true
  #     false -> investigate(transaction_cs.data)
  # end

  # defp investigate(transaction_cs) do
    
  # end

end
