defmodule Demo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do
    field :type, :string
    #? previous transaction_id and digital signature of invoice
    field :hash_of_invoice, :string

    field :input_type, :string
    field :ssu_type, :string

    #? who pays ABC? which ts in his/her/its wallet?
    field :input_id, :binary_id
    field :input_name, :string 
    field :input_email, :string 
    field :input_family_id, :binary_id
    field :input_group_id, :binary_id
    field :input_supul_id, :binary_id 
    field :input_state_supul_id, :binary_id
    field :input_nation_supul_id, :binary_id 
    
    field :ssu_id, :binary_id
    field :ssu_name, :string 
    field :ssu_email, :string 
    field :ssu_family_id, :binary_id
    field :ssu_group_id, :binary_id
    field :ssu_supul_id, :binary_id 
    field :ssu_state_supul_id, :binary_id
    field :ssu_nation_supul_id, :binary_id 

    field :gps, {:array, :map} 
    field :tax, :decimal, precision: 12, scale: 4, default: 0.0
    field :gopang_fee, :decimal, precision: 12, scale: 4, default: 0.0
    field :insurance, :string

    field :t1_input_id, :binary_id  
    field :t1_input_name, :string 
    field :t1_output_id, :binary_id  
    field :t1_output_name, :string  
    field :t1_input_ts, {:array, :map}, default: []
    field :t1_amount, :decimal, precision: 15, scale: 4

    field :items, {:array, :binary_id}
    field :fiat_currency, :decimal, precision: 15, scale: 4
    field :transaction_status, :string, default: "Processing..." #? processing, pending, completed
    field :if_only_item, :string 
    field :fair?, :boolean, default: false
    
    field :supul_code, :integer, default: 0
    field :event_hash, :string

    field :locked?, :boolean, default: false
    field :archived?, :boolean, default: false

    field :input_currency, :string
    field :ssu_currency, :string

    belongs_to :invoice, Demo.Invoices.Invoice, type: :binary_id
    has_one :openhash, Demo.Openhashes.Openhash
    has_many :tickets, Demo.Gopang.Ticket, on_delete: :delete_all
        
    many_to_many(
      :entities,
      Demo.Entities.Entity,
      join_through: Demo.Transactions.EntitiesTransactions,
      on_replace: :delete
      )

    timestamps()
  end

  @fields [
    :type, 
    #? previous transaction_id and digital signature of invoice
    :hash_of_invoice, 
    
    :input_type, 
    :ssu_type, 

    #? who pays ABC? which ts in his/her/its wallet?
    :input_id, 
    :input_name,  
    :input_email,  
    :input_family_id, 
    :input_group_id, 
    :input_supul_id,  
    :input_state_supul_id, 
    :input_nation_supul_id,  
    
    :ssu_id, 
    :ssu_name,  
    :ssu_email,  
    :ssu_family_id, 
    :ssu_group_id, 
    :ssu_supul_id,  
    :ssu_state_supul_id, 
    :ssu_nation_supul_id,  

    :gps,  
    :tax, 
    :gopang_fee, 
    :insurance, 
    :t1_input_id,   
    :t1_input_name,  
    :t1_output_id,   
    :t1_output_name,   
    :t1_input_ts, 
    :t1_amount, 
    :items, 
    :fiat_currency, 
    :transaction_status, 
    :if_only_item,  
    :fair?, 
    
    :supul_code, 
    :event_hash, 

    :locked?, 
    :archived?, 
    :payload, 
    :payload_hash,       
  ]


  def changeset(transaction, attrs) do 
    transaction
    |> cast(attrs, @fields)
    |> validate_required([])
    # |> put_assoc(:entities, [attrs.entity])
    |> put_assoc(:invoice, attrs.invoice) 
    |> put_change(:t1_amount, attrs.invoice.total) 
    # |> check_fair_trade(attrs)
  end
  
  def changeset_openhash(transaction, attrs) do 
    transaction
    |> cast(attrs, @fields)
    |> put_assoc(:openhash, attrs.openhash)
    # |> check_fair_trade(attrs)
  end


end
