defmodule Demo.Nation do
  use Ecto.Schema

  schema "nations" do
    field :name, :string

    has_many :national_airports, Demo.NationalAirport
  end
end
