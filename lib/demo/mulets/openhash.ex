defmodule Demo.Mulets.Openhash do
  use Ecto.Schema
  import Ecto.Changeset

  schema "openhashes" do
    field :payload_hash, :string
    field :chained_hash, :string, default: "origin"

    timestamps()
  end

  @doc false
  def changeset(openhash, attrs) do
    openhash
    |> cast(attrs, [:payload_hash, :chained_hash])
    |> validate_required([])
  end
end
