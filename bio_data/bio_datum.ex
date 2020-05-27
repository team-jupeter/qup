defmodule Demo.BioData.BioDatum do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "usweight" do
    field :blood_pressure, :string
    field :blood_sugar, :string
    field :blood_type, :string
    field :dna, :string
    field :fingerprint, :string
    field :footprint, :string
    field :health_status, :string
    field :iris_pattern, :string
    field :medic_treatments, :string
    field :vision, :string
    field :weight, :string

    timestamps()
  end

  @doc false
  def changeset(bio_datum, attrs) do
    bio_datum
    |> cast(attrs, [:weight, :fingerprint, :footprint, :blood_type, :blood_pressure, :dna, :medic_treatments, :vision, :iris_pattern, :blood_sugar, :health_status])
    |> validate_required([:weight, :fingerprint, :footprint, :blood_type, :blood_pressure, :dna, :medic_treatments, :vision, :iris_pattern, :blood_sugar, :health_status])
  end
end
