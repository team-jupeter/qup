defmodule Demo.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "banks" do
    field :name, :string
    field :nationality, :string

    has_many :entities, Demo.Entities.Entity
    belongs_to :nation, Demo.Nations.Nation

    timestamps()
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:name, :nationality])
    |> validate_required([:name, :nationality])
  end
end
