defmodule Demo.Invoices.Payment do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :prev_txn, :string
      
      embeds_many :t1, Demo.ABC.T1
    end
  
    @fields [:prev_txn]
    def changeset(payment, params) do
      payment
      |> cast(params, @fields)
      |> validate_required(@fields)
    end
  end
  