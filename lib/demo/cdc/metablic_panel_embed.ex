defmodule Demo.CDC.MetabolicPanelEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :collection_date, :naive_datetime
        field :received_date, :naive_datetime
        field :reported_date, :naive_datetime
        
        field :test, :string
        field :result, :string
        field :flag, :string
        field :units, :string
        field :reference_range, :string

        timestamps()
    end
  
    @fields [
        
    ]
    @doc false
    def changeset(medic_panel, attrs \\ %{}) do
      medic_panel
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
