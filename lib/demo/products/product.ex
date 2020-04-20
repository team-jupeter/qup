defmodule Demo.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :state, :string
    field :category, :string
    field :name, :string
    field :base_price, :integer
    field :discount, :integer
    field :ownership_history, :string
    field :remark, :string

    belongs_to :trade, Demo.Trades.Trade
    belongs_to :user, Demo.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :category, :base_price])
    # |> validate_required([:name, :category])
  end
end
