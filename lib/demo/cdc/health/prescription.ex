defmodule Demo.CDC.Prescription do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "prescriptions" do
    field :clinic_id, :string #? entity_id
    field :doctor, :string #? entity_id
    field :dignosis, :string
    field :comment, :string
    field :medicine, :string
    field :infection, :boolean
    field :test, :string #? document uid

    belongs_to :health_report, Demo.CDC.HealthReport, type: :binary_id
    has_many :treatments, Demo.CDC.Treatment

    timestamps()
  end

  @doc false
  def changeset(prescription, attrs) do
    prescription
    |> cast(attrs, [])
    |> validate_required([])
  end
end
