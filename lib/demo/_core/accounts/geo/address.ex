defmodule Demo.Geo.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "addresses" do
    field :city, :string
    field :nation, :string
    field :state, :string
    field :street, :string

    belongs_to :user, Demo.Accounts.User, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:city, :street, :state, :nation])
    |> validate_required([:city, :street, :state, :nation])
  end
end
