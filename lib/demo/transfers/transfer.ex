defmodule Demo.Transfers.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transfers" do
    field :type, :string

    field :input_id, :binary_id
    field :input_name, :string 
    field :input_email, :string 
    field :input_tel, :string 
    field :input_gab, :string 
    field :input_supul_id, :binary_id 
    field :input_state_supul_id, :binary_id
    field :input_nation_supul_id, :binary_id 

    field :input_currency, :string
    field :input_amount, :decimal, precision: 15, scale: 4

    field :output_id, :binary_id
    field :output_name, :string 
    field :output_email, :string 
    field :output_tel, :string 
    field :output_gab, :string 
    field :output_supul_id, :binary_id 
    field :output_state_supul_id, :binary_id
    field :output_nation_supul_id, :binary_id 

    field :output_currency, :string
    field :output_amount, :decimal, precision: 15, scale: 4

    field :fair?, :boolean, default: false


    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    has_one :openhash, Demo.Openhashes.Openhash

    timestamps()
  end

  @fields [
    :type, 

    :input_id, 
    :input_name,  
    :input_email,  
    :input_tel,  
    :input_gab,  
    :input_supul_id,  
    :input_state_supul_id, 
    :input_nation_supul_id,  

    :input_currency, 
    :input_amount, 

    :output_id, 
    :output_name,  
    :output_email,  
    :output_tel,  
    :output_gab,  
    :output_supul_id,  
    :output_state_supul_id, 
    :output_nation_supul_id,  

    :output_currency, 
    :output_amount, 

    :fair?, 
  ]
  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
