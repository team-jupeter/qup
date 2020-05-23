defmodule Demo.Reports.Ledger do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "ledgers" do
    field :txn, :string
    field :sender, :string 
    
    timestamps()
  end

  @doc false
  def changeset(ledger, attrs \\ %{}) do
    ledger
    |> cast(attrs, [])
    |> validate_required([])
  end
end
