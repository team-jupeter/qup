defmodule Demo.CDC.TestUnitEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        

        timestamps()
    end
  
    @fields [
        
    ]
    @doc false
    def changeset(test_units, attrs \\ %{}) do
      test_units
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
