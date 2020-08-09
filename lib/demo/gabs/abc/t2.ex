defmodule Demo.ABC.T2 do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.ABC.T2
   
  embedded_schema do 
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

    
    #? locking script and conditions of spending moneny by recipient.
    embeds_one :abc_locker, Demo.ABC.ABCLockerEmbed

  end

  @fields [
    [:usd, :eur, :jpy, :gbp, :aud, :cad, :chf, :cny, :sek, :mxn, :nzd, :sgd, :hkd, :nok, :krw]
  ]
  def changeset(t2, params) do
    t2
    |> cast(params, @fields)
    |> validate_required([])
  end

  def merge_changeset(%T2{} = t2, params) do
    t2
    |> cast(Map.keys(params), @fields)
    |> validate_required([])
  end
end
 