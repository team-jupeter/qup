defmodule Demo.ABC.T1 do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :input_from, :string
    field :output_to, :string
    field :amount, :decimal, precision: 12, scale: 2
  end

  @fields [:prev_txn, :amount]
  def changeset(t1, params) do
    t1
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
 