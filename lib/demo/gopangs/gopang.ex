defmodule Demo.Gopangs.Gopang do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "gopangs" do
    field :name, :string

    belongs_to :supul, Demo.Supuls.Supul
    timestamps()
  end

  @doc false
  def changeset(gopang, attrs) do
    gopang
    |> cast(attrs, [])
    |> validate_required([])
  end
end
