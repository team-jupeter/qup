defmodule Demo.Jangs.Jang do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jangs" do
    field :cart, :string

    timestamps()
  end

  @doc false
  def changeset(jang, attrs) do
    jang
    |> cast(attrs, [:cart])
    |> validate_required([:cart])
  end
end
