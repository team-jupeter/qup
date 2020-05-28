defmodule Demo.Patents.Patent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "patents" do
    field :name, :string #? KIPO

    timestamps()
  end

  @doc false
  def changeset(patent, attrs) do
    patent
    |> cast(attrs, [])
    |> validate_required([])
  end
end
