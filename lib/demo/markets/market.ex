defmodule Demo.Markets.Market do
  use Ecto.Schema
  import Ecto.Changeset

  schema "margets" do

    timestamps()
  end

  @doc false
  def changeset(market, attrs) do
    market
    |> cast(attrs, [])
    |> validate_required([])
  end
end
