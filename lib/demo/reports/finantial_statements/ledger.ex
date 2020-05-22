defmodule Demo.Reports.Ledger do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "ledgers" do
    field :comment, :string
    
    has_many :transactions, Demo.Transactions.Transaction

    timestamps()
  end

  @doc false
  def changeset(ledger, attrs \\ %{}) do
    ledger
    |> cast(attrs, [])
    |> validate_required([])
  end
end
