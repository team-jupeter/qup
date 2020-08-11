defmodule Demo.Gabs.Gab do
  use Ecto.Schema
  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "gabs" do
    field :name, :string
    field :unique_digits, :string
    field :tels, {:array, :string}

    field :t1_balance, :decimal, precision: 20, scale: 4, default: 0.0
    field :t2_balance, :decimal, precision: 20, scale: 4, default: 0.0
    field :t3_balance, :decimal, precision: 20, scale: 4, default: 0.0
    field :t4_balance, :decimal, precision: 20, scale: 4, default: 0.0
    field :t5_balance, :decimal, precision: 20, scale: 4, default: 0.0

    has_one :money_pool, Demo.MoneyPools.MoneyPool
    has_one :fiat_pool, Demo.FiatPools.FiatPool

    has_one :t1_pool, Demo.T1Pools.T1Pool
    has_one :t2_pool, Demo.T2Pools.T2Pool
    has_one :t3_pool, Demo.T3Pools.T3Pool
    has_one :t4_pool, Demo.T4Pools.T4Pool

    belongs_to :supul, Demo.Supuls.Supul

    timestamps()
  end

  @fields [
    :name, 
    :unique_digits,
    :tels, 
    :t1_balance, 
    :t2_balance, 
    :t3_balance, 
    :t4_balance, 
    :t5_balance, 
  ]
  @doc false
  def changeset(gab, attrs) do
    gab
    |> cast(attrs, @fields)
    |> put_assoc(:t1_pool, attrs.t1_pool)
    |> put_assoc(:t2_pool, attrs.t2_pool)
    |> put_assoc(:t3_pool, attrs.t3_pool)
    |> put_assoc(:t4_pool, attrs.t4_pool)
    |> validate_required([])
  end
end
