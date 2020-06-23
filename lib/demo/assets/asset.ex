defmodule Demo.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :name, :string
    field :owners, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :type, :owners])
    |> validate_required([:name, :type, :owners])
  end
end
