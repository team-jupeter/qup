defmodule Demo.Airport.NationalAirport do
  use Ecto.Schema

  schema "national_airports" do
    field :name, :string

    # belongs_to :nation, Demo.Nation
    belongs_to :airport, Demo.Airport
  end
end
