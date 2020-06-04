defmodule Demo.Schools.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "students" do
    field :name, :string 
    field :finished_courses, {:array, :string}
    field :current_courses, {:array, :string}
    field :past_schools, {:array, :string}
    field :desired_jobs, {:array, :string}
    field :recommended_jobs, {:array, :string}
  
    embeds_many :scores, Demo.Schools.ScoreEmbed, on_replace: :delete
    embeds_many :prizes, Demo.Schools.PrizeEmbed, on_replace: :delete
    embeds_many :certificates, Demo.Certificates.Certificate, on_replace: :delete
    embeds_one :learning_path, Demo.Schools.LearningPathEmbed, on_replace: :delete

    belongs_to :user, Demo.Users.User, type: :binary_id
    belongs_to :school, Demo.Schools.School, type: :binary_id


    many_to_many(
      :courses,
      Demo.Schools.Course,
      join_through: "students_courses",
      on_replace: :delete
    )

    timestamps()
  end

  @fields [
    :name, :finished_courses, :current_courses, :past_schools,
    :desired_jobs, :recommended_jobs, :user_id, :school_id
  ]
  @doc false
  def changeset(student, attrs \\ %{}) do
    student
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
