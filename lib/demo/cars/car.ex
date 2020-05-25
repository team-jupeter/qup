defmodule Demo.Cars.Car do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Cars.Car

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "cars" do
    field :category, :string 
    field :name, :string 
    field :gpc_code, :string
    field :current_cargo_amount, :string
    field :current_cargo_type, :string
    field :current_location, :string
    field :destination, :string
    field :location_history, {:array, :string}
    field :moving, :boolean, default: false
    field :front_car, :string
    field :manufacturer, :string
    field :production_date, :naive_datetime
    field :waste_date, :naive_datetime
    field :status, {:array, :string}, default: ["normal"]
    field :book_value, :decimal, precision: 15, scale: 4
    field :market_value, :decimal, precision: 15, scale: 4

    field :current_owner, :binary_id
    field :new_owner, :binary_id
    field :owner_history, {:array, :binary_id}, default: []
    field :current_legal_status, {:array, :string}, default: []
    field :txn_history, {:array, :binary_id}, default: []
    field :recent_txn_id, :binary_id


    field :input, :string
    field :output, :string

    timestamps()
  end

  @fields [
    :category, :name, :production_date, :current_location, 
    :location_history, :status, :moving, :destination, 
    :current_cargo_type, :current_cargo_amount, :market_value,
    :book_value, :waste_date, :current_owner, :new_owner, 
    :owner_history, :current_legal_status, :txn_history,
    :recent_txn_id, :input, :output
  ]
  @doc false
  def changeset(car, attrs \\ %{}) do
    car
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def owner_changeset(%Car{} = car, attrs \\ %{}) do
    IO.inspect attrs
    car
    |> cast(attrs, @fields)
    |> validate_required([])
    |> change_owner(attrs.new_owner)
    |> record_transaction(attrs.recent_txn_id)
  end


  defp change_owner(car_cs, new_owner) do
    Car.changeset(car_cs, %{owner_history: [car_cs.data.current_owner | car_cs.data.owner_history], current_owner: new_owner})
  end

  defp record_transaction(car_cs, recent_txn_id) do
    Car.changeset(car_cs, %{txn_history: [recent_txn_id | car_cs.data.txn_history]}) 
  end
end
