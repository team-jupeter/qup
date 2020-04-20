# 한국공항공사, 미국공항공사, 일본공항공사....
defmodule Demo.Airports.NationalAirport do

  use Ecto.Schema

  schema "national_airports" do
    field :name, :string

    # belongs_to :nation, Demo.Nation
    has_many :airports, Demo.Airports.Airport
    belongs_to :nation, Demo.Nation
  end
end
