defmodule Demo.Gab.Reservoir do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "reservoirs" do #? singleton table ==> Redis
    field :abc_t1, :decimal, precision: 20, scale: 2, default: Decimal.from_float(1000.00)
    field :abc_t2, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :abc_t3, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    
    field :f0, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f1, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f7, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f33, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f34, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f44, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f49, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f61, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f65, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f81, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f82, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f84, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f86, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f852, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f886, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)
    field :f972, :decimal, precision: 20, scale: 2, default:  Decimal.from_float(1000.00)

    timestamps()
  end

  @doc false
  def changeset(reservoir, attrs) do
    reservoir
    |> cast(attrs, [])
    |> validate_required([])
  end
end
