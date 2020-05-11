defmodule Demo.Taxations.Taxation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "taxations" do
    field :name, :string

    has_many :entities, Demo.Entities.Entity
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(taxation, attrs) do
    taxation
    |> cast(attrs, [:name, :nationality])
    |> validate_required([:name, :nationality])
  end
end
