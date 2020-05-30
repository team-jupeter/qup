defmodule Demo.Gopangs.StationEmbed do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :location, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(station, attrs) do
    station
    |> cast(attrs, [])
    |> validate_required([])
  end
end
