defmodule Demo.Supuls.StateSupul do
  use Ecto.Schema
  import Ecto.Changeset

  schema "state_supuls" do
    field :geographical_area, :string
    field :name, :string
    field :nationality, :string

    has_many :unit_supuls, Demo.Supuls.UnitSupul
    belongs_to :national_supul, Demo.Supuls.NationalSupul

    timestamps()
  end

  @doc false
  def changeset(state_supul, attrs) do
    state_supul
    |> cast(attrs, [:name, :nationality, :geographical_area])
    |> validate_required([:name, :nationality, :geographical_area])
  end
end
