# 아시아나, 대한항공, 에어부산, 제주항공, 에어아시아....
defmodule Demo.Airport.Airline do
  use Ecto.Schema

  schema "airlines" do
    field :name, :string
    many_to_many :airports, Demo.Airport, join_through: "airports_airlines"
  end
end
