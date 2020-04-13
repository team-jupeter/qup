defmodule Demo.Trades.Seller do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sellers" do
    field :name, :string

    belongs_to :user, Demo.Accounts.User
    belongs_to :trade, Demo.Trades.Trade
    has_many :products, Demo.Products.Product

    timestamps()
  end

  @doc false
  def changeset(seller, attrs) do
    seller
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
