defmodule Demo.FairTrades.FairTrade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fair_trades" do

    timestamps()
  end

  @doc false
  def changeset(fair_trade, attrs) do
    fair_trade
    |> cast(attrs, [])
    |> validate_required([])
  end
end
