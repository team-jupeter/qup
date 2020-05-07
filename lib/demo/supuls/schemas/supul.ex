defmodule Demo.Supuls.Supul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "supuls" do
    field :geographical_area, :string
    field :name, :string
    field :nationality, :string

    has_many :accounts, Demo.Accounts.Account
    timestamps()
  end

  @doc false
  def changeset(supul, attrs) do
    supul
    |> cast(attrs, [:name, :nationality, :geographical_area])
    |> validate_required([:name, :nationality, :geographical_area])
  end
end
