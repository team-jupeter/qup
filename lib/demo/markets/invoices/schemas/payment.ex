defmodule Demo.Invoices.Payment do
    use Ecto.Schema
    import Ecto.Changeset

    embedded_schema do
      field :prev_transaction, :string
      
      embeds_many :t1, Demo.ABC.OpenT1
    end
  
    @fields [:prev_transaction]
    def changeset(payment, params) do
      payment
      |> cast(params, @fields)
      |> validate_required(@fields)
    end
  end
  