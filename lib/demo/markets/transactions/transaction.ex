defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do
    field :type, :string
    #? previous transaction_id and digital signature of invoice
    field :hash_of_invoice, :string

    #? who pays ABC? which t1s in his/her/its wallet?
    field :buyer_name, :string 
    field :buyer_id, :binary_id
    field :erl_supul_name, :string 
    field :erl_supul_id, :binary_id
    
    field :seller_name, :string 
    field :seller_id, :binary_id
    field :ssu_supul_name, :string
    field :ssu_supul_id, :binary_id

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
    
    field :supul_code, :integer, default: 0
    field :event_hash, :string

    field :locked?, :boolean, default: false
    field :archived?, :boolean, default: false
    field :payload, :string
    field :payload_hash, :string

    belongs_to :invoice, Demo.Invoices.Invoice, type: :binary_id
    has_many :openhash, Demo.Supuls.Openhash
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
    :type, :hash_of_invoice, :buyer_name, :seller_name, :buyer_id, :seller_id, 
    :erl_supul_name, :erl_supul_id, :ssu_supul_name, :ssu_supul_id,  
    :gps, :tax, :insurance, :abc_input_id, :abc_input_name,  
    :abc_output_id, :abc_output_name, :abc_input_t1s, :abc_amount, 
    :items, :fiat_currency, :transaction_status, :if_only_item, 
    :fair?, :gopang_fee, :archived?, :payload, :payload_hash,
    :event_hash,
  ]


  def changeset(transaction, attrs) do 
    transaction
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:entities, [attrs.entity])
    |> put_assoc(:invoice, attrs.invoice)
    |> put_change(:abc_amount, attrs.invoice.total) 
    # |> check_fair_trade(attrs)
  end
  
  def changeset_openhash(transaction, attrs) do 
    transaction
    |> cast(attrs, @fields)
    |> put_assoc(:openhash, attrs.openhash)
    # |> check_fair_trade(attrs)
  end


end
