defmodule Demo.Gopangs.RoadSectionEmbed do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :section_uid, :string
    field :a_spot, :map
    field :b_spot, :map

    timestamps()
  end

  @doc false
  def changeset(road_section, attrs) do
    road_section
    |> cast(attrs, [])
    |> validate_required([])
  end
end
