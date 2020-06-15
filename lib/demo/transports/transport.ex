defmodule Demo.Transports.Transport do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Terminals.Terminal

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transports" do
    field :transport_type, :string
    field :transport_id, :string
    field :capacity, :string
    field :purpose, :string

    belongs_to :entity, Demo.Accounts.Entity, type: :binary_id

    many_to_many(
      :terminals,
      Terminal,
      join_through: "terminals_transports",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(transport, attrs \\ %{}) do
    transport
    |> cast(attrs, [])
    |> validate_required([])
  end
end


