defmodule Demo.Gopang.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tickets" do
    field :departure, :string
    field :destination, :string
    field :input, {:array, :map}, default: []
    field :output, {:array, :map}, default: []
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
    field :item_id, :binary_id
    field :item_size, {:array, :map}
    field :item_weight, :integer
    field :caution, :string
    field :gopang_fee, :decimal, precision: 15, scale: 4
    field :status, :string, default: "ticket accepted"
    field :distance, :decimal, precision: 15, scale: 4
  
    embeds_many :road_sections, Demo.Gopangs.RoadSectionEmbed
    embeds_many :stations, Demo.Gopangs.StationEmbed
    embeds_one :route, Demo.Gopangs.RouteEmbed
    embeds_one :deliverybox, Demo.Gopangs.DeliveryboxEmbed

    belongs_to :transaction, Demo.Transactions.Transaction, type: :binary_id
    belongs_to :entity, Demo.Business.Entity, type: :binary_id
    belongs_to :car, Demo.Cars.Car, type: :binary_id

    timestamps()
    end
  

    @fields [
      :departure,
      :destination,
      :input, 
      :output, 
      :departure_time, 
      :arrival_time, 
      :item_id, 
      :item_size, 
      :item_weight, 
      :caution, 
      :gopang_fee,
    ]

  @doc false
  def changeset(ticket, attrs \\ %{}) do
    ticket
    |> cast(attrs, @fields)
    |> validate_required([])
    |> cast_embed(:route) 
  end
end
