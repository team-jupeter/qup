defmodule Demo.Supuls.UnitSupul do
  use Ecto.Schema
  import Ecto.Changeset

  schema "unit_supuls" do
    field :geographical_area, :string
    field :name, :string
    field :nationality, :string

    belongs_to :state_supul, Demo.Supuls.StateSupul

    timestamps()
  end

  @doc false
  def changeset(unit_supul, attrs) do
    unit_supul
    |> cast(attrs, [:name, :nationality, :geographical_area])
    |> validate_required([:name, :nationality, :geographical_area])
  end
end
