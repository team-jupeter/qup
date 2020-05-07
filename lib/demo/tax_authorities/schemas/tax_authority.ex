defmodule Demo.Taxes.TaxAuthority do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tax_authorities" do
    field :name, :string
    field :nationality, :string

    has_many :entities, Demo.Entities.Entity
    belongs_to :nation, Demo.Nations.Nation

    timestamps()
  end

  @doc false
  def changeset(tax_authority, attrs) do
    tax_authority
    |> cast(attrs, [:name, :nationality])
    |> validate_required([:name, :nationality])
  end
end
