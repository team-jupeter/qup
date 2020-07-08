defmodule Demo.Mulets.Mulet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Mulets.Mulet

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "mulets" do
    field :hash_history, {:array, :string}, default: []
    field :current_hash, :string
    field :incoming_hash, :string

    has_one :ticket_storage, Demo.Mulets.TicketStorage

    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Demo.GlobalSupuls.GlobalSupul, type: :binary_id

    timestamps()
  end
 

    @doc false
  def changeset(%Mulet{} = mulet, attrs \\ %{}) do
    mulet
    |> cast(attrs, [:hash_history, :current_hash, :incoming_hash])
    |> validate_required([])
    |> generate_hash(attrs.incoming_hash)
  end

  defp generate_hash(mulet_cs, incoming_hash) do
    old_current_hash = mulet_cs.data.current_hash
    new_current_hash = mulet_cs.data.current_hash <> incoming_hash
    
    # new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    new_hash = :crypto.hash(:sha256, new_current_hash)
    |> Base.encode16()
    |> String.downcase()

    # IO.inspect [old_current_hash | mulet_cs.data.hash_history]
    %Demo.Mulets.Mulet{hash_history: [old_current_hash | mulet_cs.data.hash_history], current_hash: new_hash}
  end

  
end
