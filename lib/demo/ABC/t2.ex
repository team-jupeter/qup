defmodule Demo.ABC.T2 do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :prev_tx, :string
      field :amount, :decimal, precision: 12, scale: 2
    end
    
    @fields [:prev_txn, :amount]
    def changeset(t2, params) do
      t2
      |> cast(params, @fields)
      |> validate_required(@fields)
    end
  end