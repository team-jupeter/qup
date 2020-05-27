defmodule Demo.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "documents" do
    field :content, :string
    field :summary, :string
    field :table_of_content, {:array, :string}
    field :titile, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs \\ %{}) do
    document
    |> cast(attrs, [:titile, :summary, :table_of_content, :content])
    |> validate_required([:titile, :summary, :table_of_content, :content])
  end
end
