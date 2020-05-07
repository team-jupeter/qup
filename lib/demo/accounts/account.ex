defmodule Demo.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "accounts" do
    field :email, :string
    field :balance, :decimal, default: Decimal.new(0)
    field :locked, :boolean, default: false

    belongs_to :supul, Demo.Supuls.Supul
    belongs_to :entity, Demo.Entities.Entity


    timestamps()
  end

  @doc false
  def changeset(account, attrs \\ %{}) do
    account
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> unique_constraint(:email)

  end


end
