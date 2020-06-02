defmodule Demo.CDC.MetabolicItemEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :test, :string
        field :result, :string
        field :abnormal, :boolean, default: false
        field :value, :decimal, precision: 5, scale: 2
        field :flag, :string
        field :units, :string
        field :reference_range, :string
        field :basic, :boolean, default: false

        timestamps()
    end
  
    @fields [
      :collection_date, :received_date, :reported_date, 
      :test, :result, :abnormal, :value, :flag, :units, 
      :basic, :reference_range, 
    ]
    @doc false
    def changeset(medic_item, attrs \\ %{}) do
      medic_item
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
