defmodule Demo.Mulets.Openhash do
  use Ecto.Schema
  import Ecto.Changeset

  schema "openhashes" do
    field :type, :string #? 씨줄 seejule, 날줄 naljule 

    field :buyer_id, :binary_id
    field :buyer_name, :string
    field :seller_id, :binary_id
    field :seller_name, :string

    field :input, :binary_id #? 씨줄 => the receiving supul, 날줄 => the sending supul
    field :input_name, :string
    field :output, :binary_id #? always the receiving supul
    field :output_name, :string

    field :payload_hash, :string
    field :chained_hash, :string, default: "origin"

    timestamps()
  end

  @doc false
  def changeset(openhash, attrs) do
    openhash
    |> cast(attrs, [:payload_hash, :chained_hash])
    |> validate_required([])
  end
end
