defmodule Demo.T5s.T5 do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t5s" do
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
    belongs_to :gab_account, Demo.GabAccounts.GabAccount, type: :binary_id
    # belongs_to :gab, Demo.Gabs.Gab, type: :binary_id
    belongs_to :balance_sheet, Demo.Reports.BalanceSheet, type: :binary_id

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
  def changeset(t5, attrs) do
    t5
    |> cast(attrs, @fields)
    |> put_assoc(:entity, attrs.entity)
    |> validate_required([])
  end
end
