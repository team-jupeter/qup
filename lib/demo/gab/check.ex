defmodule Demo.Gab.Check do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "checks" do
    field :sender_bank_id, :string
    field :sender_entity_id, :string
    field :receiving_entity_id, :string
    field :which_fiat_currency, :string
    field :amount, :decimal, precision: 12, scale: 2

    timestamps()
  end

  @doc false
  def changeset(check, attrs) do
    check
    |> cast(attrs, [:sender_bank_id, :sender_entity_id, :receiving_entity_id, :which_fiat_currency, :amount])
    |> validate_required([])
  end
end
