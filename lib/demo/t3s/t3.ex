defmodule Demo.T3s.T3 do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "t3s" do
    field :abc, :decimal, precision: 12, scale: 4, default: 0.0

    belongs_to :gab_account, Demo.GabAccounts.GabAccount, type: :binary_id
    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id

    timestamps()
  end

  @fields [
     
  ]
  @doc false
  def changeset(t3, attrs) do
    t3
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
