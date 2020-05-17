defmodule Demo.Taxations.Taxation do
  use Ecto.Schema
  import Ecto.Changeset

  #? This schema is for Tax Authority of a supul including a nation supul.

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "taxations" do
    field :name, :string

    has_many :entities, Demo.Entities.Entity
    has_many :tax_rates, Demo.Taxations.TaxRate
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id

    timestamps()
  end

  @fields [:name]
  @doc false
  def changeset(taxation, attrs) do
    taxation
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
