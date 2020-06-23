defmodule Demo.Schools.LearningPathEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
      field :current_schools, {:array, :string}
      field :learning_path, {:array, :map}
  
      timestamps()
    end
  
    @fields [
        :current_schools, :learning_path
    ]
    @doc false
    def changeset(path, attrs) do
      path
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
  