defmodule Demo.FoodSupplies.FoodSupply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_supplies" do
    field :name, :string
    
    timestamps()
  end

  @doc false
  def changeset(food_supply, attrs) do
    food_supply
    |> cast(attrs, [])
    |> validate_required([])
  end
end
