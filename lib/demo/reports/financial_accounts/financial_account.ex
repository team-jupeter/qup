defmodule Demo.FinancialAccounts.FinancialAccount do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "financial_accounts" do
    field :account, :string
    field :left, :string
    field :right, :string

    belongs_to :entity, Demo.Accounts.Entity, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(financial_account, attrs) do
    financial_account
    |> cast(attrs, [:left, :right, :account])
    |> validate_required([:left, :right, :account])
  end
end
