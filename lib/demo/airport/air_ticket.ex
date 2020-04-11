defmodule Demo.Airport.AirTicket do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Demo.Trade.Transaction

  schema "air_tickets" do

    field :airline, :string # unique id of a human being
    field :departure_airport, :string
    field :arrival_airport, :string
    field :boarding_time, :date
    field :boarding_gate, :date
    field :boarding_door, :date
  end
end
