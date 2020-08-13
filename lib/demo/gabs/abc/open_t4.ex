defmodule Demo.ABC.OpenT4 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.OpenT4
   
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
  def changeset(t4, params) do
    t4
    |> cast(params, @fields)
    |> validate_required([])
  end

  def merge_changeset(%OpenT4{} = t4, params) do
    t4
    |> cast(Map.keys(params), @fields)
    |> validate_required([])
  end
end
 