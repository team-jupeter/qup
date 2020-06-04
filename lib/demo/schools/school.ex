defmodule Demo.Schools.School do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "schools" do
    field :type, :string
    field :monthly_tution_fee, :decimal, precision: 8, scale: 2

    has_many :students, Demo.Schools.Student

    embeds_many :graduates, Demo.Schools.GraduateEmbed

    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.Supuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.Supuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Demo.Supuls.GlobalSupul, type: :binary_id

    many_to_many(
      :mentors,
      Demo.Schools.Mentor,
      join_through: "schools_mentors",
      on_replace: :delete
    )

    many_to_many(
      :courses,
      Demo.Schools.Course,
      join_through: "schools_courses",
      on_replace: :delete
    )
    timestamps()
  end

  @fields [
    :type, :monthly_tution_fee, 
  ]
  @doc false
  def changeset(school, attrs \\ %{}) do
    school
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
