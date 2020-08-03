defmodule Demo.GabAccounts.GabAccount do
  use Ecto.Schema
  import Ecto.Changeset
  
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "gab_accounts" do
    field :credit_limit, :string
    field :owner, :string
    field :gab_balance, :decimal, default: 0.0

    embeds_many :ts, Demo.ABC.T1, on_replace: :delete

    belongs_to :group, Demo.Groups.Group, type: :binary_id
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
  
    timestamps()
  end
  @fields [
    :credit_limit, :owner, :gab_balance, 
  ]
  @doc false
  def changeset(gab_account, attrs \\ %{}) do
    gab_account
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
