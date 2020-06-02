defmodule Demo.CDC.TestResultEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :result, :string #? noraml, abnormal
        field :flac, :string #? L, H == low, high
        field :reference_range, :string #? ex) 8.6 - 10.2
        field :units, :string #? ex) mEq/L
        field :comment, :string

        timestamps()
    end
  
    @fields [
        
    ]
    @doc false
    def changeset(test_results, attrs \\ %{}) do
      test_results
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
