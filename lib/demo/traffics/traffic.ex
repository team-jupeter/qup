defmodule Demo.Traffics.Traffic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "traffics" do
    field :air_routes, :string
    field :airline_amount, :string
    field :car_amount, :string
    field :land_routes, :string
    field :ship_amount, :string
    field :water_routes, :string

    timestamps()
  end

  @doc false
  def changeset(traffic, attrs) do
    traffic
    |> cast(attrs, [:car_amount, :airline_amount, :ship_amount, :land_routes, :water_routes, :air_routes])
    |> validate_required([:car_amount, :airline_amount, :ship_amount, :land_routes, :water_routes, :air_routes])
  end
end
