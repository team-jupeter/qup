defmodule Demo.Campus.School do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "schools" do
    field :description, :string
    field :mentors, :string
    field :title, :string

    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:title, :description, :mentors])
    |> validate_required([:title, :description, :mentors])
  end
end
