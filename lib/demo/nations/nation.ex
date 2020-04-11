# 한국, 일본, 중국, 미국 ...
defmodule Demo.Nation do
  use Ecto.Schema

  schema "nations" do
    field :name, :string

    has_one :national_airport,  Demo.Airport.NationalAirport
  end
end
