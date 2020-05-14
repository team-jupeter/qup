defmodule Demo.Taxations.TaxRate do
  use Ecto.Schema
  import Ecto.Changeset

_ = '''
product and service classification
A~Z 대분류
A~Z 중분류
A~Z 소분류
A~Z 세분류
A~Z 세세분류
가능한 상품 및 서비스의 종류 24^5 = 7,962,624
'''
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "tax_rates" do
    field :gpc_code, :string

    #? add tax on price as much as tax_percent of price
    field :tax_percent, :decimal, precision: 5, scale: 2
    field :place_code, :string
    field :time_code, :string

    belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(tax_rate, attrs) do
    tax_rate
    |> cast(attrs, [:gpc, :rate, :time_code, :place_code])
    |> validate_required([:gpc, :rate])
  end
end
