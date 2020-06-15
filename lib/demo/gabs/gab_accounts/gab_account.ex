defmodule Demo.GabAccounts.GabAccount do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "gab_accounts" do
    field :balance, :decimal, defalut: Decimal.from_float(0.0)
    field :transactions, {:array, :map}
    
    belongs_to :user, Demo.Accounts.User, type: :binary_id

    timestamps()
  end

  @fields [
    :balance, :transactions
  ]
  @doc false
  def changeset(gab_account, attrs) do
    gab_account
    |> cast(attrs, @fields)
    |> validate_required([:balance])
  end
end
