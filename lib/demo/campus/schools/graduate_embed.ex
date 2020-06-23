defmodule Demo.Schools.GraduateEmbed do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :entity_id, :binary_id
    field :entrance_date, :date
    field :graduate_date, :date
    field :graduate_exam_score, :integer

    timestamps()
  end

  @doc false
  def changeset(graduate, attrs) do
    graduate
    |> cast(attrs, [])
    |> validate_required([])
  end
end
