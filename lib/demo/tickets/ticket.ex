defmodule Demo.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Demo.Trades.Trade

  schema "tickets" do

    field :transportation, :string # unique id of a human being
    field :departure, :string
    field :arrival, :string
    field :boarding_time, :date
    field :boarding_gate, :string
    field :boarding_door, :string
  end

  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:transportation, :departure, :arrival, :boarding_time, :boarding_gate, :boarding_door])
    |> validate_required([:transportation, :departure, :arrival, :boarding_time, :boarding_gate, :boarding_door])
    # |> validate_format(:boarding_time)
  end
end
