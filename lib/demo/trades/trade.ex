defmodule Demo.Trades.Trade do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Accounts.User

  schema "trades" do
    field :dummy_product, :string
    field :dummy_buyer, :string
    field :dummy_seller, :string

    has_many :products, Demo.Products.Product
    belongs_to :unit_supul, Demo.Supuls.UnitSupul
    many_to_many(
      :users,
      User,
      join_through: "users_trades",
      on_replace: :delete
      )

    timestamps()
  end

  def trade_changeset(trade, attrs) do
    trade
    |> cast(attrs, [:dummy_product, :dummy_buyer, :dummy_seller])
    |> validate_required([:dummy_product])
  end

  def changeset(trade, attrs) do
    trade
    |> cast(attrs, [:dummy_product, :dummy_buyer, :dummy_seller])
    |> validate_required([:dummy_product])
  end
end
