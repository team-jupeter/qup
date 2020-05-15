defmodule Demo.Licenses.License do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "licenses" do
    field :licence_code, :string
    field :issued_at, :string
    field :issued_by, :string
    field :issued_date, :naive_datetime
    field :name, :string

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    timestamps()
  end

  @doc false
  def changeset(license, attrs) do
    license
    |> cast(attrs, [:licence_code, :name, :issued_by, :issued_at, :issued_to])
    |> validate_required([])
  end
end
