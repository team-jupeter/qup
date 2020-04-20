defmodule Demo.Supuls.NationalSupul do
  use Ecto.Schema
  import Ecto.Changeset

  schema "national_supuls" do
    field :geographical_area, :string
    field :name, :string

    has_many :state_supuls, Demo.Supuls.StateSupul
    belongs_to :continental_supul, Demo.Supuls.ContinentalSupul
    has_many :unit_supuls, through: [:state_supuls, :unit_supuls]

    timestamps()
  end

  @doc false
  def changeset(national_supul, attrs) do
    national_supul
    |> cast(attrs, [:name, :geographical_area])
    |> validate_required([:name, :geographical_area])
  end
end
