defmodule Demo.TaxRate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tax_rates" do
    field :gpc, :string
    field :place_code, :string
    field :time_code, :string

    timestamps()
  end

  @doc false
  def changeset(tax_rate, attrs) do
    tax_rate
    |> cast(attrs, [:gpc, :time_code, :place_code])
    |> validate_required([:gpc, :time_code, :place_code])
  end
end
