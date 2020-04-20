defmodule Demo.Supuls.ContinentalSupul do
  use Ecto.Schema
  import Ecto.Changeset

  schema "continental_supuls" do
    field :geographical_area, :string
    field :name, :string

    has_many :national_supuls, Demo.Supuls.NationalSupul
    
    timestamps()
  end

  @doc false
  def changeset(continental_supul, attrs) do
    continental_supul
    |> cast(attrs, [:name, :geographical_area])
    |> validate_required([:name, :geographical_area])
  end
end
