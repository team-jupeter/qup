defmodule Demo.GabAccounts.GabAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gab_accounts" do
    field :credit_limit, :string
    field :owner, :string
    field :t1, :string
    field :t2, :string
    field :t3, :string

    timestamps()
  end

  @doc false
  def changeset(gab_account, attrs) do
    gab_account
    |> cast(attrs, [:owner, :t1, :t2, :t3, :credit_limit])
    |> validate_required([:owner, :t1, :t2, :t3, :credit_limit])
  end
end
