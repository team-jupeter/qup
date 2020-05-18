defmodule Demo.Reservoir do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "reservoirs" do
    field :f0, :decimal, precision: 12, scale: 2, default: 0.0
    field :f1, :decimal, precision: 12, scale: 2, default: 0.0
    field :f7, :decimal, precision: 12, scale: 2, default: 0.0
    field :f33, :decimal, precision: 12, scale: 2, default: 0.0
    field :f34, :decimal, precision: 12, scale: 2, default: 0.0
    field :f44, :decimal, precision: 12, scale: 2, default: 0.0
    field :f49, :decimal, precision: 12, scale: 2, default: 0.0
    field :f61, :decimal, precision: 12, scale: 2, default: 0.0
    field :f65, :decimal, precision: 12, scale: 2, default: 0.0
    field :f81, :decimal, precision: 12, scale: 2, default: 0.0
    field :f82, :decimal, precision: 12, scale: 2, default: 0.0
    field :f84, :decimal, precision: 12, scale: 2, default: 0.0
    field :f86, :decimal, precision: 12, scale: 2, default: 0.0
    field :f852, :decimal, precision: 12, scale: 2, default: 0.0
    field :f886, :decimal, precision: 12, scale: 2, default: 0.0
    field :f972, :decimal, precision: 12, scale: 2, default: 0.0

    timestamps()
  end

  @doc false
  def changeset(reservoir, attrs) do
    reservoir
    |> cast(attrs, [])
    |> validate_required([])
  end
end
