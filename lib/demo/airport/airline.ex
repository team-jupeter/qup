defmodule Demo.Airport.Airline do
  use Ecto.Schema

  schema "airlines" do
    field :name, :string
    many_to_many :airports, Demo.Airport, join_through: "airports_airlines"
  end
end
