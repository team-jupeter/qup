defmodule Demo.Gabs.Gab do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "gabs" do
    field :name, :string
    field :gab_balance, :decimal, default: 0.0
    field :unique_digits, :string
    field :tels, {:array, :string}

    has_one :fiat_pool, Demo.FiatPools.FiatPool
    belongs_to :nation, Demo.Nations.Nation

    timestamps()
  end

  @fields [
    :name, 
    :gab_balance,
    :unique_digits,
    :tels, 
  ]
  @doc false
  def changeset(gab, attrs) do
    gab
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
