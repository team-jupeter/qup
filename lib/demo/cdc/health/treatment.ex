defmodule Demo.CDC.Treatment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "treatments" do
    field :clinic_id, :string
    field :doctor, :string
    field :nurse, :string

    field :disease, :string
    field :comment, :string

    belongs_to :prescription, Demo.CDC.Prescription, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(treatment, attrs) do
    treatment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
