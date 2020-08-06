defmodule Demo.GabAccounts.GabAccount do
  use Ecto.Schema
  import Ecto.Changeset
  
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "gab_accounts" do
    field :credit_limit, :string
    field :entity_name, :string
    field :gab_balance, :decimal, default: 0.0
    field :unique_digits, :string
    field :default_fiat, :string

    field :t1, :decimal, default: 0.0
    field :t2, :decimal, default: 0.0
    field :t3, :decimal, default: 0.0
    field :t4, :decimal, default: 0.0
    field :t5, :decimal, default: 0.0

    embeds_many :ts, Demo.ABC.T1, on_replace: :delete

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :group, Demo.Groups.Group, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
  
    timestamps()
  end
  @fields [
    :t1, :t2, :t3, :t4, :t5,
    :credit_limit, :entity_name, :gab_balance, :unique_digits, :default_fiat, 
  ]
  @doc false
  def changeset(gab_account, attrs \\ %{}) do
    gab_account
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
