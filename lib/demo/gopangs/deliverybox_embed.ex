defmodule Demo.Gopangs.DeliveryboxEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
      field :code, :string
      field :status, :string
      field :current_location, :map

      timestamps()
    end
  
    @doc false
    def changeset(deliverybox, attrs) do
      deliverybox
      |> cast(attrs, [])
      |> validate_required([])
    end
  end
  