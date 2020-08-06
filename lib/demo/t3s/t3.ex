defmodule Demo.T3s.T3 do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t3s" do
    field :price, :string
    field :current_owner, :string

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @fields [:current_owner, :price]
  @doc false
  def changeset(t3, attrs) do
    t3
    |> cast(attrs, @fields)
    |> put_assoc(:current_owner, attrs.current_owner)
    |> validate_required([])
  end
end
