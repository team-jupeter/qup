#? Ecto.Multi
defmodule Demo.Mulets.Mulet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Demo.Mulets.Mulet

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "mulets" do
    field(:sil, :map)
    field(:operation, :string)
    field(:changes, :map)

    belongs_to :supul, Demo.Supuls.Supul
    has_many :sils, Demo.Mulets.Sil

    timestamps()
  end

  def changeset(report, attrs) do
    report
    |> cast(attrs, [])
    |> validate_required([])
  end
  
  def changeset_for_insert(%Changeset{} = changeset) do
    change(%Mulet{operation: "insert", sil: serialize_schema(changeset.data)})
  end

  def changeset_for_insert(%{__meta__: %Ecto.Schema.Metadata{}} = sil) do
    change(%Mulet{operation: "insert", sil: serialize_schema(sil)})
  end

  def changeset_for_insert(_other) do
    raise "changeset_for_insert can only accept a schema struct or a changeset"
  end

  defp serialize_schema(schema) do
    schema.__struct__.__schema__(:fields)
    |> Enum.reduce(%{}, fn field, acc ->
      Map.put(acc, field, Map.get(schema, field))
    end)
  end
end
