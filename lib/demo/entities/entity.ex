defmodule Demo.Entities.Entity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Invoices.Invoice

  alias Demo.Accounts.User
  # alias Demo.Products.Product
  alias Demo.Entities.Entity
  alias Demo.Repo
  # alias Demo.Supuls.Supul
  # alias Demo.Groups.Group
  # alias Demo.Groups
  # alias Demo.FinancialReports
  # alias Demo.BalanceSheets
  # alias Demo.IncomeStatements
  # alias Demo.CFStatements
  # alias Demo.EquityStatements

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "entities" do
    field :type, :string
    field :name, :string
    field :unique_digits, :string
    field :telephones, {:array, :string}
    field :project, :string
    field :supul_name, :string
    field :email, :string
    field :gps, {:array, :map}
    field :nationality, :string
    field :company_prefix, :string
    field :auth_code, :string
    field :entity_address, :string
    field :entity_code, :string
    field :founding_date, :date
    field :t1_balance, :decimal, default: Decimal.from_float(0.0)
    # ? Standard Industrial Classification
    field :sic_code, :string
    # ? Corporation, Foundation, NGO ...
    field :legal_status, :string
    field :year_started, :integer
    field :year_ended, :integer
    field :num_of_shares, {:array, :map}
    field :share_price, {:array, :map}
    # ? AAA, ..., FFF => 24 rates
    field :credit_rate, :string
    field :supul_code, :binary_id

    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_confirmation, :string, virtual: true

    field :locked, :boolean, default: false
    field :nation_signature, :string

    # ? true if this entity is the first entity of the group.
    field :default_group, :boolean, default: false
    field :default_currency, :string, default: "KRW"

    # embeds_many :business_embeds, Demo.Entities.BusinessEmbed, on_replace: :delete

    has_one :color_code, Demo.ColorCodes.ColorCode, on_replace: :delete
    has_one :sil, Demo.Sils.Sil, on_replace: :delete
    has_one :account_book, Demo.AccountBooks.AccountBook, on_replace: :delete
    has_one :financial_report, Demo.Reports.FinancialReport, on_replace: :delete
    has_one :balance_sheet, Demo.Reports.BalanceSheet, on_replace: :delete
    has_one :income_statement, Demo.Reports.IncomeStatement, on_replace: :delete
    has_one :cf_statement, Demo.Reports.CFStatement, on_replace: :delete
    has_one :equity_statement, Demo.Reports.EquityStatement, on_replace: :delete
    has_one :gab_account, Demo.GabAccounts.GabAccount, on_replace: :delete

    has_many :licenses, Demo.Licenses.License

    has_one :t2_item, Demo.ABC.OpenT2Item

    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id, on_replace: :delete
    belongs_to :nation, Demo.Nations.Nation, type: :binary_id, on_replace: :delete

    belongs_to :family, Demo.Families.Family, type: :binary_id, on_replace: :delete
    belongs_to :group, Demo.Groups.Group, type: :binary_id, on_replace: :delete
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id, on_replace: :delete
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id, on_replace: :delete
    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id, on_replace: :delete
    belongs_to :biz_category, Demo.Taxations.Taxation, type: :binary_id, on_replace: :delete

    has_many :reports, Demo.Reports.Report
    # has_many :certificates, Demo.Certificates.Certificate
    has_many :machines, Demo.Machines.Machine
    has_many :labs, Demo.Labs.Lab
    has_many :products, Demo.Products.Product

    has_one :invoice, Demo.Invoices.Invoice
    # many_to_many(
    #   :invoices,
    #   Invoice,
    #   join_through: "entities_invoices",
    #   on_replace: :delete
    # )

    many_to_many(
      :transactions,
      Invoice,
      join_through: Demo.Transactions.EntitiesTransactions,
      on_replace: :delete
    )

    many_to_many(
      :users,
      User,
      join_through: "users_entities",
      on_replace: :delete
    )

    # many_to_many(
    #   :groups,
    #   Group,
    #   join_through: "entities_groups",
    #   on_replace: :delete
    # )

    # many_to_many(
    #   :products,
    #   Product,
    #   join_through: "entities_products",
    #   # join_through: Demo.Products.AccountsProducts,
    #   on_replace: :delete
    # )

    # ? inserted_at, updated_at
    timestamps()
  end

  @fields [
    :type,
    :nationality,
    :company_prefix,
    :auth_code,
    :nation_id,
    :email,
    :name,
    :unique_digits, 
    :telephones, 
    :entity_address,
    :nation_signature,
    :biz_category_id,
    :sic_code,
    :legal_status,
    :year_started,
    :num_of_shares,
    :supul_name,
    :t1_balance,
    :supul_id,
    :share_price,
    :credit_rate,
    :project,
    :default_group,
    :default_currency,
  ]

  def changeset(entity, attrs ) do
    entity
    |> cast(attrs, @fields)
    |> validate_required([])
    |> validate_format(:email, ~r/@/)
    |> put_assoc(:nation, attrs.nation)
    |> put_assoc(:supul, attrs.supul)
    |> put_assoc(:gab_account, attrs.ga)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:gab, attrs.gab)
  end

  def create_default_entity(entity, current_user, attrs) do
    changeset(entity, attrs)
    |> put_assoc(:users, [current_user])
    |> put_assoc(:family, attrs.family)
    |> put_assoc(:account_book, attrs.ab)
  end

  def create_default_entity(entity, attrs) do
    changeset(entity, attrs)
    |> put_assoc(:users, [attrs.user])
    |> put_assoc(:family, attrs.family)
    |> put_assoc(:account_book, attrs.ab)
  end

  def create_other_entity(entity, current_user, attrs) do
    changeset(entity, attrs)
    |> put_assoc(:users, [current_user])
    |> put_assoc(:group, attrs.group)
    |> put_assoc(:income_statement, attrs.is)
  end

  def create_other_entity(entity, attrs) do
    changeset(entity, attrs)
    |> put_assoc(:users, [attrs.user])
    |> put_assoc(:group, attrs.group)
    |> put_assoc(:income_statement, attrs.is)
  end

  def changeset_update_users(%Entity{} = entity, users) do
    entity
    |> Repo.preload(:users)
    |> change()
    |> put_assoc(:users, users)
    |> Repo.update!()
  end

  def changeset_update_entity(%Entity{} = entity, attrs) do
    entity
    |> cast(attrs, @fields)
  end

  def changeset_update_products(%Entity{} = entity, products) do
    entity
    |> Repo.preload(:products)
    |> change()
    # ? many to many between products and entities
    |> put_assoc(:products, products)
    |> Repo.update!()
  end

  def changeset_update_invocie(%Entity{} = entity, invocie) do
    entity
    |> Repo.preload(:invocie)
    |> change()
    |> put_assoc(:invocie, invocie)
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
