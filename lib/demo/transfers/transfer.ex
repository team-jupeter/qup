defmodule Demo.Transfers.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "transfers" do
    field :type, :string

    field :erl_id, :binary_id
    field :erl_name, :string 
    field :erl_email, :string 
    field :erl_tel, :string 
    field :erl_supul_id, :binary_id 
    field :erl_state_supul_id, :binary_id
    field :erl_nation_supul_id, :binary_id 
    
    field :ssu_id, :binary_id
    field :ssu_name, :string 
    field :ssu_email, :string 
    field :ssu_tel, :string 
    field :ssu_supul_id, :binary_id 
    field :ssu_state_supul_id, :binary_id
    field :ssu_nation_supul_id, :binary_id 

    field :t1_input_email, :string  
    field :t1_input_name, :string 
    field :t1_output_email, :string  
    field :t1_output_name, :string  
    field :t1_input_t1s, {:array, :map}, default: []
    field :t1_amount, :decimal, precision: 15, scale: 4

    field :fair?, :boolean, default: false

    field :erl_currency, :string
    field :ssu_currency, :string

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    has_one :openhash, Demo.Openhashes.Openhash

    timestamps()
  end

  @fields [
   :type,

   :erl_id,
   :erl_name, 
   :erl_email, 
   :erl_supul_id, 
   :erl_state_supul_id,
   :erl_nation_supul_id, 
    
   :ssu_id,
   :ssu_name, 
   :ssu_email, 
   :ssu_supul_id, 
   :ssu_state_supul_id,
   :ssu_nation_supul_id, 

   :t1_input_email,  
   :t1_input_name, 
   :t1_output_email,  
   :t1_output_name,  
   :t1_input_t1s, 
   :t1_amount, 

   :fair?, 

   :erl_currency,
   :ssu_currency,
  ]
  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
