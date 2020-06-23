defmodule Demo.RealEstates.RealEstate do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.RealEstates.RealEstate

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "real_estates" do
    field :category, :string 
    field :address, :string 
    field :gpc_code, :string

    field :longitude, :string
    field :latitude, :string
    field :altitude, :string

    field :book_value, :decimal, precision: 15, scale: 4
    field :market_value, :decimal, precision: 15, scale: 4

    field :current_owner, :binary_id
    field :new_owner, :binary_id
    field :owner_history, {:array, :binary_id}, default: []
    field :current_legal_status, {:array, :string}, default: []
    field :transaction_history, {:array, :binary_id}, default: []
    field :recent_transaction_id, :binary_id

    field :input, :string
    field :output, :string
    
    timestamps()
  end


@fields [
  :category, :address, :gpc_code, :market_value,
  :longitude, :latitude, :altitude,
  :book_value, :current_owner, :new_owner, 
  :owner_history, :current_legal_status, :transaction_history,
  :recent_transaction_id, :input, :output,
]

  @doc false
  def changeset(real_estate, attrs \\ %{}) do
    real_estate
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def owner_changeset(%RealEstate{} = real_estate, attrs \\ %{}) do
    real_estate
    |> cast(attrs, @fields)
    |> validate_required([])
    |> change_owner(attrs.new_owner)
    |> record_transaction(attrs.recent_transaction_id)
  end


  defp change_owner(real_estate_cs, new_owner) do
    RealEstate.changeset(real_estate_cs, %{owner_history: [real_estate_cs.data.current_owner | real_estate_cs.data.owner_history], current_owner: new_owner})
  end
  
  defp record_transaction(real_estate_cs, recent_transaction_id) do
    RealEstate.changeset(real_estate_cs, %{transaction_history: [recent_transaction_id | real_estate_cs.data.transaction_history]}) 
  end
end
