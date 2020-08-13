defmodule Demo.T2s.T2 do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t2s" do 
    field :usd, :decimal, precision: 12, scale: 4, default: 0.0
    field :eur, :decimal, precision: 12, scale: 4, default: 0.0
    field :jpy, :decimal, precision: 12, scale: 4, default: 0.0
    field :gbp, :decimal, precision: 12, scale: 4, default: 0.0
    field :aud, :decimal, precision: 12, scale: 4, default: 0.0
    field :cad, :decimal, precision: 12, scale: 4, default: 0.0
    field :chf, :decimal, precision: 12, scale: 4, default: 0.0
    field :cny, :decimal, precision: 12, scale: 4, default: 0.0
    field :sek, :decimal, precision: 12, scale: 4, default: 0.0
    field :mxn, :decimal, precision: 12, scale: 4, default: 0.0
    field :nzd, :decimal, precision: 12, scale: 4, default: 0.0
    field :sgd, :decimal, precision: 12, scale: 4, default: 0.0
    field :hkd, :decimal, precision: 12, scale: 4, default: 0.0
    field :nok, :decimal, precision: 12, scale: 4, default: 0.0
    field :krw, :decimal, precision: 12, scale: 4, default: 0.0

    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id
    belongs_to :gab_account, Demo.GabAccounts.GabAccount, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @fields [
    [:usd, :eur, :jpy, :gbp, :aud, :cad, :chf, :cny, :sek, :mxn, :nzd, :sgd, :hkd, :nok, :krw]
  ]
  @doc false
  def changeset(t2, attrs) do
    t2
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
