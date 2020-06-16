defmodule Demo.Licenses.License do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "licenses" do
    field :licence_code, :string
    field :issued_to, :string
    field :issued_by, :string
    field :issued_date, :date
    field :name, :string
    field :document, :binary_id

    belongs_to :entity, Demo.Business.Entity, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(license, attrs \\ %{}) do
    license
    |> cast(attrs, [:licence_code, :name, :issued_by, :issued_to, :issued_to])
    |> validate_required([])
  end
end
