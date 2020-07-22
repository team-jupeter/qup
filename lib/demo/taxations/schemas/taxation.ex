defmodule Demo.Taxations.Taxation do
  use Ecto.Schema
  import Ecto.Changeset

  #? This schema is for Tax Authority of a supul including a nation supul.

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "taxations" do
    field :name, :string
    field :auth_code, :string

    has_many :entities, Demo.Entities.Entity
    has_many :tax_rates, Demo.Taxations.TaxRate

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id

    timestamps()
  end

  @fields [:name, :auth_code]

  def changeset(taxation, attrs = %{auth_code: auth_code}) do
    taxation
    |> cast(attrs, @fields)
    |> put_change(:auth_code, attrs.auth_code)
  end
  @doc false 
  def changeset(taxation, attrs) do
    taxation
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:nation, attrs.nation)
  end
end
