defmodule Demo.Labs.Lab do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "labs" do
    field :gpc_code, :string
    field :location, :map
    field :purpose, :string

    belongs_to :entity, Demo.Business.Entity, type: :binary_id

    timestamps()
  end

  @fields [:gpc_code, :location, :purpose]
  @doc false
  def changeset(lab, attrs) do
    lab
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
