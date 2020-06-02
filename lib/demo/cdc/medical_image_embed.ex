defmodule Demo.CDC.MedicalImageEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :collection_date, :naive_datetime
        field :received_date, :naive_datetime
        field :reported_date, :naive_datetime
        
        field :x_ray, :string
        field :ct, :string
        field :mri, :string

        timestamps()
    end
  
    @fields [
        
    ]
    @doc false
    def changeset(medic_image, attrs \\ %{}) do
      medic_image
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
