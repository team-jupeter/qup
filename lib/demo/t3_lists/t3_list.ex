defmodule Demo.T3Lists.T3List do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  
  schema "t3_lists" do
    field :num_of_shares, :decimal, default: 0.0
    field :price_per_share, :decimal, default: 0.0

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    has_many :t3, Demo.ABC.T3

    timestamps()
  end

  @doc false
  def changeset(t3_list, attrs) do
    t3_list
    |> cast(attrs, [:num_of_shares, :price_per_share])
    |> validate_required([:num_of_shares, :price_per_share])
  end
end
