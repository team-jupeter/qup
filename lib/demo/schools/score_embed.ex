defmodule Demo.Schools.ScoreEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :subject, :string
    field :test_date, :naive_datetime
    field :test_type, :string
    field :score, :string #? A, B, C, D, F
  end


  @fields [
    :subject, :test_date, :test_type, :score, 
  ]
  def changeset(score, params \\ %{}) do
    score
    |> cast(params, @fields)
    |> validate_required([])
  end
end
