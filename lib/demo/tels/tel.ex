defmodule Demo.Tels.Tel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tels" do
    field :unique_digits, :integer
    field :telephone_nums, {:array, :integer}


    belongs_to :gab_account, Demo.GabAccounts.GabAccount, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id

    timestamps()
  end

  @fields [
    :number, :nation
  ]
  @doc false
  def changeset(tel, attrs) do
    tel
    |> cast(attrs, @fields)
    |> validate_required([])
    |> unique_constraint([:unique_digits, :telephone_nums])
  end
end
