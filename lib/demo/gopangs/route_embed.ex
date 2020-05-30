defmodule Demo.Gopangs.RouteEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    @primary_key {:id, :binary_id, autogenerate: true}
    embedded_schema do
      field :departure_spot, :map
      field :arrival_spot, :map

      timestamps()
    end
  
    @doc false
    def changeset(route, attrs \\ %{}) do
      route
      |> cast(attrs, [:departure_spot, :arrival_spot])
      |> validate_required([])
    end
  end
  