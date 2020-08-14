defmodule Demo.ABC.OpenT1 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.OpenT1
   
  embedded_schema do 
    field :openhash_id, :binary_id

    field :input_name, :string
    field :input_id, :string
    field :output_name, :string
    field :output_id, :string
    field :input_amount, :decimal, precision: 12, scale: 2
    field :input_currency, :string
    field :output_amount, :decimal, precision: 12, scale: 2
    field :output_currency, :string
    
    #? locking script and conditions of spending moneny by recipient.
    embeds_one :abc_locker, Demo.ABC.ABCLockerEmbed

  end

  @fields [
      :openhash_id, :input_name, :output_name, :input_id, :output_id, 
      :input_amount, :input_currency, :output_amount, :output_currency, 
  ]
  def changeset(open_t1, params) do
    open_t1
    |> cast(params, @fields)
    |> validate_required([])
  end

  def merge_changeset(%OpenT1{} = open_t1, params) do
    open_t1
    |> cast(Map.keys(params), @fields)
    |> validate_required([])
  end
end
 