defmodule Demo.Trades.Buyer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "buyers" do
    field :name, :string

    belongs_to :user, Demo.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(buyer, attrs) do
    buyer
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
