defmodule Demo.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :category, :string
    field :name, :string

    belongs_to :user, Demo.Accounts.User
    belongs_to :trade, Demo.Trades.Trade

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :category])
    |> validate_required([:name, :category])
  end
end
