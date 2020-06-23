defmodule Demo.Schools.Course do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "courses" do
    field :subject_title, :string
    field :subject_category, :string
    field :produced_by, :binary_id
    field :production_date, :date
    field :finished_by, {:array, :binary_id}
    field :num_of_subscribers, :integer
    field :current_subscribers, {:array, :binary_id}
    field :past_subscribers, {:array, :binary_id}
    field :avg_completion_days, :decimal, precision: 8, scale: 2 #? days to complete the course
    
    many_to_many(
      :students,
      Demo.Schools.Student,
      join_through: "students_courses",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [])
    |> validate_required([])
  end
end
