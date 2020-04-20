# 한국, 일본, 중국, 미국 ...
defmodule Demo.Nations.Nation do
  use Ecto.Schema

  schema "nations" do
    field :name, :string

    has_one :national_airport,  Demo.Airports.NationalAirport
    has_one :bank,  Demo.Banks.Bank
    has_one :tax,  Demo.Taxes.Tax
    has_many :companies, Demo.Companies.Company

  end
end
