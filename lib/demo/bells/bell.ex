defmodule Demo.Bells.Bell do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "bells" do
    field :what, :string
    field :when, :string
    field :where, :string
    field :who, :string
    field :why, :string

    timestamps()
  end

  @doc false
  def changeset(bell, attrs) do
    bell
    |> cast(attrs, [:who, :when, :where, :what, :why])
    |> validate_required([:who, :when, :where, :what, :why])
  end
end
