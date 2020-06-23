defmodule Demo.Tickets.Payload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payloads" do
    field :payload, :string

    belongs_to :supul, Demo.Supuls.Supul

    timestamps()
  end

  @doc false
  def changeset(payload, attrs \\ %{}) do
    payload
    |> cast(attrs, [])
    |> validate_required([])
  end
end
