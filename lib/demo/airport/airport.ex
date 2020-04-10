defmodule Demo.Airport do
  use Ecto.Schema

  schema "airports" do
    field :name, :string
    field :tagline, :string

    has_many :passengers, Demo.Airport.Passenger
    has_one :national_airport, Demo.Airport.NationalAirport
    many_to_many :airlines, Demo.Airport.Airline, join_through: "airports_airlines"
  end
end
