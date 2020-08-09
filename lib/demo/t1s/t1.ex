defmodule Demo.T1s.T1 do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t1s" do
    field :openhash_id, :binary_id
    field :input_name, :string
    field :input_id, :string
    field :output_name, :string
    field :output_id, :string
    field :amount, :decimal, precision: 12, scale: 2
    field :currency_type, :string

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @fields [
    :openhash_id, 
    :input_name, 
    :input_id, 
    :output_name, 
    :output_id, 
    :amount, 
    :currency_type, 
  ]
  @doc false
  def changeset(t1, attrs) do
    t1
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
