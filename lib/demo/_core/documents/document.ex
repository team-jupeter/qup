defmodule Demo.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "documents" do
    field :title, :string
    field :presented_by, {:array, :binary_id}, default: []
    field :presented_to, :binary_id
    field :summary, :string
    field :attached_docs_list, {:array, :string}
    field :attached_docs_hashes, {:array, :string}
    field :hash_of_attached_docs_hashes, :string

    belongs_to :product, Demo.Business.Product, type: :binary_id

    timestamps()
  end

  @fields [
    :title, 
    :presented_by,
    :presented_to,
    :summary,
    :attached_docs_list,
    :attached_docs_hashes,
    :hash_of_attached_docs_hashes,
  ]
  @doc false
  def changeset(document, attrs \\ %{}) do
    document
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
