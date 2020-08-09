defmodule Demo.T3s.T3 do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t3s" do
    field :price, :decimal, precision: 12, scale: 4, default: 0.0
    field :current_owner, :string
    field :issuer, :string
    field :issuer_code, :string
    field :number_of_issues, :string

    field :put_price, :decimal, precision: 12, scale: 4, default: 0.0
    field :call_price, :decimal, precision: 12, scale: 4, default: 0.0

    field :issued_at, :date
    field :putable_from, :date
    field :callable_from, :date

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :balance_sheet, Demo.BalanceSheets.BalanceSheet, type: :binary_id

    timestamps()
  end

  @fields [
    :price,
    :current_owner,
    :issuer,
    :issuer_code,
    :number_of_issues,

    :put_price, 
    :call_price, 

    :issued_at,
    :putable_from,
    :callable_from,
  ]
  @doc false
  def changeset(t3, attrs) do
    t3
    |> cast(attrs, @fields)
    |> put_assoc(:entity, attrs.entity)
    |> validate_required([])
  end
end
