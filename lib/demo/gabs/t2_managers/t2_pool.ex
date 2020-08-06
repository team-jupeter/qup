defmodule Demo.ABC.T2List do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "t2_lists" do #? each nation has one t2_list.
    field :pool_amount, :decimal, precision: 15, scale: 2 #? the  amount of the pool
    field :to_buy, {:array, :map} #? select some stocks in Korean stock market to buy
    field :to_sell, {:array, :map} #? select some stocks to sell in the Korean T2 Pool
    field :t2_index, :decimal, precision: 7, scale: 2 #? divide the pool amount by the number of shares in the pool.

    has_many :t2_items, Demo.ABC.T2Item
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id 

    timestamps()
  end

  @doc false
  def changeset(pool, attrs \\ %{}) do
    pool
    |> cast(attrs, [])
    |> validate_required([])
  end
end
