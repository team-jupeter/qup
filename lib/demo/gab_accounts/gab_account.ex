defmodule Demo.GabAccounts.GabAccount do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Demo.Repo
  
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "gab_accounts" do
    field :entity_name, :string
    field :credit_limit, :decimal, precision: 12, scale: 4, default: 0.0

    field :total_balance, :decimal, precision: 12, scale: 4, default: 0.0
    field :total_book_value, :decimal, precision: 12, scale: 4, default: 0.0
    field :total_market_value, :decimal, precision: 12, scale: 4, default: 0.0

    field :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0
    field :t2_balance, :decimal, precision: 12, scale: 4, default: 0.0
    field :t3_balance, :decimal, precision: 12, scale: 4, default: 0.0
    field :t4_balance, :decimal, precision: 12, scale: 4, default: 0.0
    
    field :t1_market_value, :decimal, precision: 12, scale: 4, default: 0.0
    field :t2_market_value, :decimal, precision: 12, scale: 4, default: 0.0
    field :t3_market_value, :decimal, precision: 12, scale: 4, default: 0.0
    field :t4_market_value, :decimal, precision: 12, scale: 4, default: 0.0

    field :return_on_t1, :decimal, precision: 12, scale: 4, default: 0.0
    field :return_on_t2, :decimal, precision: 12, scale: 4, default: 0.0
    field :return_on_t3, :decimal, precision: 12, scale: 4, default: 0.0
    field :return_on_t4, :decimal, precision: 12, scale: 4, default: 0.0

    field :unique_digits, :string
    field :default_currency, :string

    embeds_many :t1s, Demo.ABC.T1, on_replace: :delete
    embeds_many :t2s, Demo.ABC.T2, on_replace: :delete
    embeds_many :t4s, Demo.ABC.T4, on_replace: :delete

    has_many :t3s, Demo.T3s.T3, on_replace: :delete

    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id

    belongs_to :entity, Demo.Entities.Entity, type: :binary_id
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :group, Demo.Groups.Group, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
  
    timestamps()
  end
  @fields [
     :credit_limit,
     :entity_name,
     :total_balance, 
     :total_book_value, 
     :total_market_value,
 
     :t1_balance,
     :t2_balance,
     :t3_balance,
     :t4_balance,
    
     :t1_market_value,
     :t2_market_value,
     :t3_market_value,
     :t4_market_value,

     :return_on_t1,
     :return_on_t2,
     :return_on_t3,
     :return_on_t4,

     :unique_digits,
     :default_currency, 
  ]
  @doc false
  def changeset(gab_account, attrs \\ %{}) do
    gab_account
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def changeset_t1_to_t2(gab_account, attrs) do
    gab_account
    |> cast(attrs, @fields)
    |> put_embed(:t1s, attrs.t1s)
    |> put_embed(:t2s, attrs.t2s)
    |> validate_required([])
  end

  def changeset_t1_to_t3(gab_account, attrs) do
    gab_account
    |> cast(attrs, @fields)
    |> put_embed(:t1s, attrs.t1s)
    |> put_embed(:t3s, attrs.t3s)
    |> validate_required([])
  end

  def changeset_t1_to_t4(gab_account, attrs) do
    gab_account
    |> cast(attrs, @fields)
    |> put_embed(:t1s, attrs.t1s)
    |> put_embed(:t4s, attrs.t4s)
    |> validate_required([])
  end

  def changeset_tx_to_t1(gab_account, attrs) do
    gab_account
    |> cast(attrs, @fields)
    |> put_embed(:t1s, attrs.t1s)
    |> validate_required([])
  end


  
end
