defmodule Demo.ABC.T1 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.T1
  
  embedded_schema do
    field :input, :string
    field :output, :string
    field :amount, :decimal, precision: 12, scale: 2

    #? locking script and conditions of spending moneny by recipient.
    field :locked, :boolean, default: false
    field :locking_use_area, {:array, :string}, default: []
    field :locking_use_until, :naive_datetime 
    field :locking_output_entity_catetory, {:array, :string}, default: []
    field :locking_output_specific_entities, {:array, :string}, default: []
    field :locking_output_specific_dates, {:array, :naive_datetime}, default: []

  end

  @fields [
      :input, :output, :amount, :locked, :locking_use_area,
      :locking_use_until, :naive_datetime, :locking_output_entity_catetory, 
      :locking_output_specific_entities, :locking_output_specific_dates,
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
 