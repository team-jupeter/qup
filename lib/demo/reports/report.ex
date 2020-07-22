defmodule Demo.Reports.Report do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "reports" do
    field :previous_report, :binary_id
    field :current_hash, :string #? hash(hash of this report except the current_hash value <> current_hash of the previous_report)
    field :title, :string
    field :written_by, :binary_id
    field :written_to, {:array, :binary_id}
    field :attached_documents, :string #? attached_documents

    belongs_to :machine, Demo.Machines.Machine, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @fields [
    :previous_report, 
    :current_hash, 
    :title,
    :written_by,
    :written_to,
    :documents,
  ]

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
