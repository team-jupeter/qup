defmodule Demo.Mulets.Mulet do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "mulets" do
    field :hash_history, {:array, :string} #? list
    field :current_hash, :string
    field :invoice_hash, :string

    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.Supuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.Supuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Demo.Supuls.GlobalSupul, type: :binary_id

    timestamps()
  end


    @doc false
  def changeset(mulet, attrs) do
    mulet
    |> cast(attrs, [:hash_history, :current_hash, :invoice_hash])
    |> validate_required([:current_hash])
    |> generate_hash(attrs.invoice_hash)
  end

  defp generate_hash(mulet_cs, invoice_hash) do
    old_current_hash = mulet_cs.data.current_hash
    new_current_hash = mulet_cs.data.current_hash <> invoice_hash
    new_hash = :crypto.hash(:sha256, new_current_hash)
    |> Base.encode16()
    |> String.downcase()

    %Demo.Mulets.Mulet{hash_history: [old_current_hash | mulet_cs.data.hash_history], current_hash: new_hash}
  end
end
