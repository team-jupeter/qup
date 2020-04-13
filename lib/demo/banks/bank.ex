defmodule Demo.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset

  schema "banks" do
    field :name, :string
    field :nationality, :string

    has_many :users, Demo.Accounts.User
    belongs_to :nation, Demo.Nation

    timestamps()
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:name, :nationality])
    |> validate_required([:name, :nationality])
  end
end
 