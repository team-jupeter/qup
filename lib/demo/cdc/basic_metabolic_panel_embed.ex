defmodule Demo.CDC.BasicMetabolicPanelEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :collection_date, :naive_datetime
        field :received_date, :naive_datetime
        field :reported_date, :naive_datetime
        
        field :sodium, {:array, :map} #? Na
        field :potassium, {:array, :map} #? K
        field :carbon_dioxide, {:array, :map} #? CO2
        field :chloride, {:array, :map} #? Cl
        field :glucose, {:array, :map}
        field :calcium, {:array, :map} #? Ca
        field :blood_urea_nitrogen, {:array, :map} #? BUN
        field :creatinie, {:array, :map}

        timestamps()
    end
  
    @fields [
        
    ]
    @doc false
    def changeset(fr_embed, attrs \\ %{}) do
      fr_embed
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
