defmodule Demo.Mulets.Payload do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "payloads" do
    field :payload, :string 

    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(payload, attrs) do
    payload
    |> cast(attrs, [:data])
    |> validate_required([:data])
  end
end
