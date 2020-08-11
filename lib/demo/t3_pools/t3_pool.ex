defmodule Demo.T3Pools.T3Pool do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t3_pools" do
    field :num_of_issues, :integer
 
    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id

    timestamps() 
  end

  @fields [
    :num_of_issues
  ]
  @doc false
  def changeset(t3_pool, attrs) do
    t3_pool
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
