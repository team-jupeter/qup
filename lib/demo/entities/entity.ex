defmodule Demo.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Invoices.Invoice

  alias Demo.Users.User
  alias Demo.Products.Product

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "entities" do
    field :entity_address, :string
    field :entity_code, :string 
    field :name, :string
    field :email, :string

    field :private_key, :string
    field :public_key, :string

    #? A user must have only one entity, and An entity may have several business_embeds. 
    embeds_many :business_embeds, Demo.Entities.BusinessEmbed, on_replace: :delete

    has_one :color_code, Demo.ColorCodes.ColorCode
    has_one :sil, Demo.Sils.Sil

    has_one :financial_report, Demo.Reports.FinancialReport
    has_many :licenses, Demo.Licenses.License

    has_one :t2_item, Demo.ABC.T2Item

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id

    has_many :reports, Demo.Reports.Report
    has_many :certificates, Demo.Certificates.Certificate
    has_many :machines, Demo.Machines.Machine
    has_many :labs, Demo.Labs.Lab
    
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

    many_to_many(
      :products,
      Product,
      join_through: "entities_products",
      # join_through: Demo.Products.EntitiesProducts,
      on_replace: :delete
    )



    timestamps() #? inserted_at, updated_at
  end

  @fields [:nation_id, :email, :supul_id, :taxation_id, :name, :entity_address, :private_key, :public_key]

  def changeset(account, attrs \\ %{}) do
    account
    |> cast(attrs, @fields)
    |> validate_required([:email])
    |> unique_constraint(:email)

  end


end
