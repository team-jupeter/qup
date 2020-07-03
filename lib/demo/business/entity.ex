defmodule Demo.Business.Entity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Invoices.Invoice

  alias Demo.Accounts.User 
  # alias Demo.Business.Product
  alias Demo.Business.Entity
  alias Demo.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "entities" do 
    field :name, :string
    field :project, :string
    field :supul_name, :string
    field :email, :string
    field :gps, {:array, :map}
    field :nationality, :string
    field :company_prefix, :string
    field :registered_no, :string
    field :entity_address, :string
    field :entity_code, :string 
    field :founding_date, :date
    field :gab_balance, :decimal, default: Decimal.from_float(0.0)
    field :sic_code, :string #? Standard Industrial Classification
    field :legal_status, :string #? Corporation, Foundation, NGO ...
    field :year_started, :integer
    field :year_ended, :integer
    field :num_of_shares, {:array, :map}
    field :share_price, {:array, :map}
    field :credit_rate, :string #? AAA, ..., FFF => 24 rates

    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_confirmation, :string, virtual: true
    
    field :locked, :boolean, default: false
    field :nation_signature, :string

    #? A user must have only one entity, and An entity may have several business_embeds. 
    # embeds_many :business_embeds, Demo.Business.BusinessEmbed, on_replace: :delete

    has_one :color_code, Demo.ColorCodes.ColorCode
    has_one :sil, Demo.Sils.Sil
    has_one :financial_report, Demo.Reports.FinancialReport
    has_one :balance_sheet, Demo.Reports.BalanceSheet
    has_one :income_statement, Demo.Reports.IncomeStatement
    has_one :cf_statement, Demo.Reports.CFStatement
    has_one :equity_statement, Demo.Reports.EquityStatement
    
    has_many :licenses, Demo.Licenses.License

    has_one :t2_item, Demo.ABC.T2Item

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    belongs_to :taxation, Demo.Taxations.Taxation, type: :binary_id
    belongs_to :biz_category, Demo.Taxations.Taxation, type: :binary_id

    has_many :reports, Demo.Reports.Report
    has_many :certificates, Demo.Certificates.Certificate
    has_many :machines, Demo.Machines.Machine
    has_many :labs, Demo.Labs.Lab
    has_many :products, Demo.Business.Product
    
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

    # many_to_many(
    #   :products,
    #   Product,
    #   join_through: "entities_products",
    #   # join_through: Demo.Products.AccountsProducts,
    #   on_replace: :delete
    # )



    timestamps() #? inserted_at, updated_at
  end

 

  @fields [
    :nationality, :company_prefix, 
    :nation_id, :email, :supul_id, :taxation_id, 
    :name, :entity_address, :nation_signature,
    :biz_category_id, :sic_code, :legal_status, :year_started, 
    :num_of_shares, :supul_name, :gab_balance,
    :share_price, :credit_rate, :project, 
  ]

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required([])
    |> validate_format(:email, ~r/@/)
    |> assoc_constraint(:biz_category)
    |> assoc_constraint(:nation)
    |> assoc_constraint(:supul)
    |> assoc_constraint(:taxation)
  end

  def changeset_update_users(%Entity{} = entity, users) do
    entity 
    |> Repo.preload(:users)
    |> change()  \
    |> put_assoc(:users, users)
    |> Repo.update!()
  end

  def changeset_update_entity(%Entity{} = entity, attrs) do
    entity 
    |> cast(attrs, @fields)
    |> Repo.update!()
  end

  def changeset_update_products(%Entity{} = entity, products) do
    entity 
    |> Repo.preload(:products)
    |> change()  \
    |> put_assoc(:products, products) #? many to many between products and entities
    |> Repo.update!()
  end

  def changeset_update_invoices(%Entity{} = entity, invoices) do
    entity 
    |> Repo.preload(:invoices)
    |> change()  \
    |> put_assoc(:invoices, invoices) #? many to many between invoices and entities
    |> Repo.update!()
  end

  def registration_changeset(entity, params) do
    entity
    |> changeset(params)
    |> cast(params, [:email, :password])
    |> validate_required([:password])
    # |> cast_embed(:address) # error
    |> validate_length(:password, min: 5, max: 10)
    # |> unique_constraint([:email]) # error
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
