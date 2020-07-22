defmodule Demo.Entities.CommentEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    # @primary_key {:id, :binary_id, autogenerate: true}
    embedded_schema do
      field :product_id, :binary_id
      field :written_by, :binary_id
      field :content, :string
      field :stars, :integer

      timestamps()
    end
  
    @doc false
    def changeset(route, attrs \\ %{}) do
      route
      |> cast(attrs, [:written_by, :content, :stars])
      |> validate_required([])
    end
  end
  