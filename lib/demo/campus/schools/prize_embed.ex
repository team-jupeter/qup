defmodule Demo.Schools.PrizeEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :title, :string
    field :granted_by, :binary_id
    field :granted_to, :binary_id
    field :description, :string
    field :granted_date, :date
  end


  @fields [
    :title, :granted_by, :granted_to, :description, :granted_date, 
  ]
  def changeset(prize, params) do
    prize
    |> cast(params, @fields)
    |> validate_required([])
  end
end
