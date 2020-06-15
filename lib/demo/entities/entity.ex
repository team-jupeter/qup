defmodule Demo.Business.Entity do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Invoices.Invoice

  alias Demo.Accounts.User
  alias Demo.Products.Product
  alias Demo.Business.Entity
  alias Demo.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "entities" do
    field :company_prefix, :string
    field :registered_no, :string
    field :industry_classification, :string
    field :entity_address, :string
    field :entity_code, :string 
    field :name, :string
    field :email, :string
    field :founding_date, :date
    field :locked, :boolean, default: false
    field :gab_balance, :decimal, default: Decimal.from_float(0.0)
   
    field :private_key, :string
    field :public_key, :string

    #? A user must have only one entity, and An entity may have several business_embeds. 
    embeds_many :business_embeds, Demo.Business.BusinessEmbed, on_replace: :delete

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
      # join_through: Demo.Products.AccountsProducts,
      on_replace: :delete
    )



    timestamps() #? inserted_at, updated_at
  end



  @fields [:company_prefix, :nation_id, :email, :supul_id, :taxation_id, :name, :entity_address, :private_key, :public_key]

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required([])
    |> validate_format(:email, ~r/@/)
  end

  def changeset_update_users(%Entity{} = entity, users) do
    entity 
    |> Repo.preload([:users])
    |> change()  \
    |> put_assoc(:users, [users])
    |> Repo.update!()
  end

  def registration_changeset(entity, params) do
    entity
    |> changeset(params)
    |> cast(params, [:email, :password])
    |> validate_required([:password])
    # |> cast_embed(:address) # error
    |> validate_length(:password, min: 5, max: 10)
    |> IO.inspect
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
