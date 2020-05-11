defmodule Demo.Supuls.Supul do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "supuls" do
    field :supul_code, :decimal, precision: 8
    field :geographical_area, :string
    field :name, :string

    has_many :accounts, Demo.Accounts.Account
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id

    timestamps()
  end

  @doc false
  @field [:name, :geographical_area, :supul_code]
  def changeset(supul, attrs) do
    supul
    |> cast(attrs, @field)
    |> validate_required(@field)
  end
end
