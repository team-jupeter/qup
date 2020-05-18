defmodule Demo.Gab.FRX do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "frxes" do
    field :f1_abc, :decimal, precision: 12, scale: 2, default: 0.1
    field :f82_abc, :decimal, precision: 12, scale: 2, default: 0.1
    field :f86_abc, :decimal, precision: 12, scale: 2, default: 0.1

    timestamps()
  end

  @doc false
  def changeset(check, attrs) do
    check
    |> cast(attrs, [:sender_bank_id, :sender_entity_id, :receiving_entity_id, :which_fiat_currency, :amount])
    |> validate_required([])
  end
end
