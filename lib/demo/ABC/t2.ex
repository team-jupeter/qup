defmodule Demo.ABC.T2 do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :input_from, :string
    field :output_to, :string
    field :amount, :decimal, precision: 12, scale: 2
  end

  @fields [:input_from, :output_to, :amount]
  def changeset(t2, params) do
    t2
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end