defmodule Demo.ABC.T3 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.T3
   
  embedded_schema do 
    field :openhash_id, :binary_id

    field :input_name, :string
    field :input_id, :string
    field :output_name, :string
    field :output_id, :string
    field :amount, :decimal, precision: 12, scale: 2
    field :currency, :string
    
    #? locking script and conditions of spending moneny by recipient.
    embeds_one :abc_locker, Demo.ABC.ABCLockerEmbed

  end

  @fields [
      :openhash_id, :input_name, :output_name, :input_id, :output_id, :amount, :currency
  ]
  def changeset(t3, params) do
    t3
    |> cast(params, @fields)
    |> validate_required([])
  end

  def merge_changeset(%T3{} = t3, params) do
    t3
    |> cast(Map.keys(params), @fields)
    |> validate_required([])
  end
end
 