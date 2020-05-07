defmodule Demo.Portals.Portal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "portals" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(portal, attrs) do
    portal
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
