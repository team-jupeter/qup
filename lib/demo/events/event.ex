defmodule Demo.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "events" do
    field :type, :string
    field :how, :string
    field :what, :string
    field :when, :string
    field :where, :string
    field :who, {:array, :binary_id}
    field :why, :string

    timestamps()
  end

  @fields [:type, :who, :when, :where, :what, :how, :why]
  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
