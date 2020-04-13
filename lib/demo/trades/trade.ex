defmodule Demo.Trades.Trade do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Accounts.User

  schema "trades" do
    field :password, :string
    field :price, :string


    has_one :product, Demo.Products.Product
    has_one :buyer, Demo.Trades.Buyer
    has_one :seller, Demo.Trades.Seller
    many_to_many(
      :users,
      User,
      join_through: "users_trades",
      on_replace: :delete
      )

    timestamps()
  end
  def trade_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 2, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
  @doc false
  def changeset(trade, attrs) do
    trade
    |> cast(attrs, [:price])
    |> validate_required([:buyer, :seller, :price, :product])
    |> validate_required(["Asina", "KAL", "JAL", "Dungfang", "Fedex"])
  end
end
