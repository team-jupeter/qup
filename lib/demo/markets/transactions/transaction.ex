defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do

    #? previous transaction_id and digital signature of invoice
    field :hash_of_invoice, :string

    #? who pays ABC? which t1s in his/her/its wallet?
    field :buyer, :string 
    field :seller, :string 
    field :buyer_id, :string
    field :seller_id, :string
    field :gps, {:array, :map} 
    field :tax, :decimal, default: 0.0
    field :insurance, :string
    field :abc_input_id, :string #? public_address of buyer. 
    field :abc_input_name, :string 
    field :abc_output_id, :string #? public_address of buyer. 
    field :abc_output_name, :string #? public_address of buyer. 
    field :abc_input_t1s, {:array, :map}, default: []
    field :abc_amount, :decimal, precision: 15, scale: 4
    field :items, {:array, :binary_id}
    field :fiat_currency, :decimal, precision: 15, scale: 4
    field :transaction_status, :string, default: "processing" #? processing, pending, completed
    field :if_only_item, :string 
    field :fair?, :boolean, default: false
    
    field :locked?, :boolean, default: false

    has_one :invoice, Demo.Invoices.Invoice, on_delete: :delete_all
    has_many :tickets, Demo.Gopang.Ticket, on_delete: :delete_all
    
    timestamps()
  end

  @fields [
    :hash_of_invoice, :buyer, :seller, :buyer_id, :seller_id,  
    :gps, :tax, :insurance, :abc_input_id, :abc_input_name,  
    :abc_output_id, :abc_output_name, :abc_input_t1s, :abc_amount, 
    :items, :fiat_currency, :transaction_status, :if_only_item, 
    :fair?, 
  ]
  @doc false
  def changeset(transaction, attrs \\ %{}) do
    transaction
    |> cast(attrs, @fields)
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
