defmodule Demo.CDCS.CDC do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "cdcs" do
    
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(cdc, attrs) do
    cdc
    |> cast(attrs, [])
    |> validate_required([])
  end
end
