defmodule Demo.CDC.MedicalImageEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :collection_date, :date
        field :received_date, :date
        field :reported_date, :date
        
        field :x_ray, :string
        field :ct, :string
        field :mri, :string

        timestamps()
    end
  
    @fields [
      :collection_date, :received_date, :reported_date, :x_ray, :ct, :mri, 
    ]
    @doc false
    def changeset(medic_image, attrs \\ %{}) do
      medic_image
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
