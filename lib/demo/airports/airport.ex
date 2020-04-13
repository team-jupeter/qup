# 인천공항, 제주공항, 간사이공항, 수두공항...
defmodule Demo.Airports.Airport do
  use Ecto.Schema

  schema "airports" do
    field :name, :string
    field :tagline, :string

    has_many :passengers, Demo.Airports.Passenger
    has_many :phones, Demo.Airport.Phone
    has_one :national_airport, Demo.Airport.NationalAirport
    many_to_many :airlines, Demo.Airport.Airline, join_through: "airports_airlines"
  end
end
