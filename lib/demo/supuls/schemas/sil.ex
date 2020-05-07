defmodule Demo.Mulets.Sil do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Demo.Mulets.Mulet

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "sils" do
    field(:sil, :map)
    field(:operation, :string)
    field(:changes, :map)

    belongs_to :mulet, Demo.Mulets.Mulet
    belongs_to :entity, Demo.Entities.Entity

    timestamps()
  end

  def changeset(report, attrs) do
    report
    |> cast(attrs, [])
    |> validate_required([])
  end
end
