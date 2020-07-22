defmodule Demo.Terminals.Terminal do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Transports.Transport
  # alias Demo.Entities.Entity

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "terminals" do
    field :address, :string
    field :name, :string
    field :tel, :string
    field :type, :string

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id

    many_to_many(
      :transports,
      Transport,
      join_through: "terminals_transports",
      on_replace: :delete
    )

    # many_to_many(
    #   :entities,
    #   Entity,
    #   join_through: "terminals_entities",
    #   on_replace: :delete
    # )

    timestamps()
  end

  @doc false
  def changeset(terminal, attrs) do
    terminal
    |> cast(attrs, [:type, :name, :address, :tel])
    |> validate_required([:type, :name, :address, :tel])
  end
end
