defmodule Demo.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Invoices.Invoice
  alias Demo.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "entities" do
    field :email, :string
    field :category, :string
    field :year_started, :integer
    field :year_ended, :integer
    field :share_price, :integer

    has_one :color_code, Demo.ColorCodes.ColorCode
    has_one :sil, Demo.Mulets.Sil

    has_many :addresses, Demo.Geo.Address

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :tax_authority, Demo.Taxes.TaxAuthority, type: :binary_id

    many_to_many(
      :invoices,
      Invoice,
      join_through: "entities_invoices",
      on_replace: :delete
    )

    many_to_many(
      :users,
      User,
      join_through: "users_entities",
      on_replace: :delete
    )

    timestamps()
  end

  @fields [:nation_id, :email]

  def changeset(account, attrs \\ %{}) do
    account
    |> cast(attrs, @fields)
    |> validate_required([:email])
    |> unique_constraint(:email)

  end


end
