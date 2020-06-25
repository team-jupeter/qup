defmodule Demo.Business.GPCCode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "gpc_codes" do
    field :code, :string
    field :name, :string
    field :standard, :string

    has_many :products, Demo.Business.Product

    timestamps()
  end

  @doc false
  def changeset(gpc_codes, attrs \\ %{}) do
    gpc_codes
    |> cast(attrs, [:standard, :code, :name])
    |> validate_required([:standard, :code, :name])
  end
end
