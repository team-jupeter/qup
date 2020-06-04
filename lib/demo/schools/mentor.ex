defmodule Demo.Schools.Mentor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "mentors" do
    field :name, :string
    field :certificates, {:array, :string}

    belongs_to :user, Demo.Users.User, type: :binary_id

    many_to_many(
      :schools,
      Demo.Schools.School,
      join_through: "schools_mentors",
      on_replace: :delete
    )
    timestamps()
  end

  @fields [
    :name, :certificates, :user_id
  ]
  @doc false
  def changeset(mentor, attrs) do
    mentor
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
