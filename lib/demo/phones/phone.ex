defmodule Demo.Phones.Phone do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phones" do
    field :name, :string

    belongs_to :airport, Demo.Airports.Airport

    timestamps()
  end

  @doc false
  def changeset(phone, attrs) do
    phone
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
