defmodule Demo.Trade.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Accounts.User

  schema "transactions" do
    field :buyer, :string
    field :price, :string
    field :product, :string
    field :seller, :string
    field :where, :string


    # belongs_to  :user, User

    timestamps()

    # belongs_to :category, Demo.Trade.Category
    many_to_many(
      :users,
      User,
      join_through: "user_transaction",
      on_replace: :delete
    )

  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:buyer, :seller, :price, :where, :product])
    |> validate_required([:buyer, :seller, :price, :where, :product])
  end
end
