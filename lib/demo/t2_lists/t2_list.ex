defmodule Demo.T2Lists.T2List do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t2_lists" do
    field :USD, :decimal, default: 0.0
    field :EUR, :decimal, default: 0.0
    field :JPY, :decimal, default: 0.0
    field :GBP, :decimal, default: 0.0
    field :AUD, :decimal, default: 0.0
    field :CAD, :decimal, default: 0.0
    field :CHF, :decimal, default: 0.0
    field :CNY, :decimal, default: 0.0
    field :SEK, :decimal, default: 0.0
    field :MXN, :decimal, default: 0.0
    field :NZD, :decimal, default: 0.0
    field :SGD, :decimal, default: 0.0
    field :HKD, :decimal, default: 0.0
    field :NOK, :decimal, default: 0.0
    field :KRW, :decimal, default: 0.0

    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(t2_list, attrs) do
    t2_list
    |> cast(attrs, [:USD, :EUR, :JPY, :GBP, :AUD, :CAD, :CHF, :CNY, :SEK, :MXN, :NZD, :SGD, :HKD, :NOK, :KRW])
    |> validate_required([:USD, :EUR, :JPY, :GBP, :AUD, :CAD, :CHF, :CNY, :SEK, :MXN, :NZD, :SGD, :HKD, :NOK, :KRW])
  end
end
