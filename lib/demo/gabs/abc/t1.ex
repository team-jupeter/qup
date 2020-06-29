defmodule Demo.ABC.T1 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.T1
  
  embedded_schema do 
    field :input_name, :string
    field :input_id, :string
    field :output_name, :string
    field :output_id, :string
    field :amount, :decimal, precision: 12, scale: 2

    #? locking script and conditions of spending moneny by recipient.
    embeds_one :abc_locker, Demo.ABC.ABCLockeEmbed

  end

  @fields [
      :input, :output, :input_id, :output_id, :amount
  ]
  def changeset(t1, params) do
    t1
    |> cast(params, @fields)
    |> validate_required([])
  end

  def merge_changeset(%T1{} = t1, params) do
    t1
    |> cast(Map.keys(params), @fields)
    |> validate_required([])
  end
end
 