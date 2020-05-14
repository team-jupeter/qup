defmodule Demo.Terminals.TerminalsTransports do
  use Ecto.Schema
  import Ecto.Changeset

  schema "terminals_transports" do
    belongs_to :terminal, Demo.Terminals.Terminal, type: :binary_id
    belongs_to :transport, Demo.Transports.Transport, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(terminals, attrs) do
    terminals
    |> cast(attrs, [])
    |> validate_required([])
  end
end
