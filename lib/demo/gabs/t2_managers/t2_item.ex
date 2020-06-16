defmodule Demo.ABC.T2Item do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "t2_items" do
    field :stock_price, :decimal, precision: 10, scale: 2 #? T1 amount this security in the pool
    field :amount, :decimal, precision: 15, scale: 2 #? T1 amount this security in the pool
    field :proportion_in_pool, :decimal, precision: 5, scale: 2 #? proportion in the pool
    field :proportion_in_market,:decimal, precision: 5, scale: 2 #? market capitalization ratio in Korean security market.
    field :intrinsic_price_gab, :decimal, precision: 7, scale: 2 #? difference between market price and re_fmv.

    belongs_to :entity, Demo.Business.Entity, type: :binary_id 
    belongs_to :t2_pool, Demo.ABC.T2Pool, type: :binary_id 

    timestamps()
  end

  @fields [:entity_id, :stock_price, :t2_pool_id, :amount, :proportion_in_pool, :proportion_in_market, :intrinsic_price_gab,]
  @doc false
  def changeset(t2_item, attrs \\ %{}) do
    t2_item
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
