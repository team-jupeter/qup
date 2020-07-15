defmodule Demo.Supuls.Openhash do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Supuls.Openhash

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "open_hashes" do
    field :txn_id, :binary_id
    field :incoming_hash, :string
    field :previous_hash, :string
    field :current_hash, :string
    field :supul_signature, :string

    belongs_to :transaction, Demo.Transactions.Transaction, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    belongs_to :global_supul, Demo.GlobalSupuls.GlobalSupul, type: :binary_id

    timestamps()
  end

  @fields [
    :txn_id,
    :incoming_hash,
    :previous_hash,
    :current_hash, 
    :supul_signature,

  ]


  # def changeset(%Openhash{} = openhash, %{supul: supul, supul_signature: supul_signature}) do    
  #   attrs = %{
  #     txn_id: supul.txn_id,
  #     previous_hash: supul.previous_hash,
  #     incoming_hash: supul.incoming_hash,
  #     current_hash: supul.current_hash,
  #   }

  #   openhash
  #   |> cast(attrs, @fields)
  #   |> validate_required([])
  # end

  def changeset(%Openhash{} = openhash, attrs = %{supul_signature: supul_signature}) do    
    IO.inspect "supul_signature"
    IO.inspect attrs.supul_signature
    
    openhash
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  @doc false
  def changeset(openhash, attrs) do
    openhash
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
