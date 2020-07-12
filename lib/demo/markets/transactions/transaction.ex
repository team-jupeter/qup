defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do

    #? previous transaction_id and digital signature of invoice
    field :hash_of_invoice, :string

    #? who pays ABC? which t1s in his/her/its wallet?
    field :buyer_name, :string 
    field :buyer_id, :binary_id
    field :buyer_supul_name, :string 
    field :buyer_supul_id, :binary_id
    
    field :seller_name, :string 
    field :seller_id, :binary_id
    field :seller_supul_name, :string
    field :seller_supul_id, :binary_id

    field :gps, {:array, :map} 
    field :tax, :decimal, default: 0.0
    field :gopang_fee, :decimal, default: 0.0
    field :insurance, :string
    field :abc_input_id, :string #? public_address of buyer. 
    field :abc_input_name, :string 
    field :abc_output_id, :string #? public_address of buyer. 
    field :abc_output_name, :string #? public_address of buyer. 
    field :abc_input_t1s, {:array, :map}, default: []
    field :abc_amount, :decimal, precision: 15, scale: 4
    field :items, {:array, :binary_id}
    field :fiat_currency, :decimal, precision: 15, scale: 4
    field :transaction_status, :string, default: "Processing..." #? processing, pending, completed
    field :if_only_item, :string 
    field :fair?, :boolean, default: false
    
    field :supul_code, :binary_id

    field :locked?, :boolean, default: false
    field :archived?, :boolean, default: false

    belongs_to :invoice, Demo.Invoices.Invoice, type: :binary_id
    # has_one :openhash, Demo.Mulets.Openhash
    has_many :tickets, Demo.Gopang.Ticket, on_delete: :delete_all
        
    many_to_many(
      :entities,
      Demo.Business.Entity,
      join_through: Demo.Transactions.EntitiesTransactions,
      on_replace: :delete
      )

    timestamps()
  end

  @fields [
    :hash_of_invoice, :buyer_name, :seller_name, :buyer_id, :seller_id, 
    :buyer_supul_name, :buyer_supul_id, :seller_supul_name, :seller_supul_id,  
    :gps, :tax, :insurance, :abc_input_id, :abc_input_name,  
    :abc_output_id, :abc_output_name, :abc_input_t1s, :abc_amount, 
    :items, :fiat_currency, :transaction_status, :if_only_item, 
    :fair?, :gopang_fee, :archived?
  ]
  @doc false
  def changeset(transaction, attrs = %{archived?: archived}) do 
    IO.puts "archived?: archived"
    transaction
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  @doc false
  def changeset(transaction, attrs) do 
    transaction
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:entities, [attrs.entity])
    |> put_assoc(:invoice, attrs.invoice)
    |> put_change(:abc_amount, attrs.invoice.total) 
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
