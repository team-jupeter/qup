defmodule Demo.ABC.T2 do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :input, :string
    field :output, :string
    field :amount, :decimal, precision: 12, scale: 2
  end

  @fields [:input, :output, :amount]
  def changeset(t2, params) do
    t2
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end