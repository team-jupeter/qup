defmodule Demo.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tickets" do
    field :transport_type, :string
    field :transport_id, :string
    field :valid_until, :naive_datetime
    field :issued_by, :string
    field :user_id, :string
    field :departure_time, :naive_datetime
    field :arrival_time, :naive_datetime
    field :departing_terminal, :string #? terminal_name
    field :arrival_terminal, :string #? terminal_name
    field :gate, :string
    field :seat, :string
    field :baggage, :decimal
    field :digital_certificate, :string

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs \\ %{}) do
    ticket
    |> cast(attrs, [])
    |> validate_required([])
  end
end
