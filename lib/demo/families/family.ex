defmodule Demo.Families.Family do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "families" do
    # ? add charater "f" to the email of the house holder.
    field :gab_balance, :decimal, default: 0.0
    field :family_code, :string
    field :nationality, :string
    field :auth_code, :string
    field :address, :string

    # ? the name of the house_holder
    field :house_holder_name, :string
    # ? the email of the house_holder
    field :house_holder_email, :string
    field :house_holder_supul_id, :string

    # ? family members' titles are relative to the house holder
    # ? the value of each field is his/her name. 
    field :grand_father_name, :string
    field :grand_mother_name, :string
    field :grand_father_in_law_name, :string
    field :grand_mother_in_law_name, :string
    field :father_name, :string
    field :mother_name, :string
    field :father_in_law_name, :string
    field :mother_in_law_name, :string
    field :husband_id, :binary_id
    field :husband_name, :string
    field :wife_id, :binary_id
    field :wife_name, :string
    field :sons, {:array, :map}
    field :dauthers, {:array, :map}
    field :grand_sons, {:array, :map}
    field :grand_dauthers, {:array, :map}
    field :relatives, {:array, :map}
    field :inmates, {:array, :map}

    field :grand_father_email, :string
    field :grand_mother_email, :string
    field :grand_father_in_law_email, :string
    field :grand_mother_in_law_email, :string
    field :father_email, :string
    field :mother_email, :string
    field :father_in_law_email, :string
    field :mother_in_law_email, :string
    field :husband_email, :string
    field :wife_email, :string

    field :entity_id_of_grand_father, :string
    field :entity_id_of_grand_mother, :string
    field :entity_id_of_grand_father_in_law, :string
    field :entity_id_of_grand_mother_in_law, :string
    field :entity_id_of_father, :string
    field :entity_id_of_mother, :string
    field :entity_id_of_father_in_law, :string
    field :entity_id_of_mother_in_law, :string
    field :entity_id_of_house_holder, :string
    field :entity_id_of_husband, :string
    field :entity_id_of_wife, :string
    field :entity_id_of_sons, {:array, :map}
    field :entity_id_of_dauthers, {:array, :map}
    field :entity_id_of_grand_sons, {:array, :map}
    field :entity_id_of_grand_dauthers, {:array, :map}
    field :entity_id_of_relatives, {:array, :map}
    field :entity_id_of_inmates, {:array, :map}

    field :payload, :string

    field :openhash_id, :binary_id

    has_many :users, Demo.Accounts.User, on_replace: :nilify
    has_many :entities, Demo.Entities.Entity, on_replace: :nilify
    has_one :wedding, Demo.Weddings.Wedding, on_replace: :nilify

    belongs_to :nation, Demo.Nations.Nation, type: :binary_id, on_replace: :nilify
    belongs_to :supul, Demo.Supuls.Supul, type: :binary_id, on_replace: :nilify

    has_one :account_book, Demo.AccountBooks.AccountBook, on_replace: :nilify 
    has_one :financial_report, Demo.Reports.FinancialReport, on_replace: :nilify
    has_one :balance_sheet, Demo.Reports.BalanceSheet, on_replace: :nilify
    has_one :cf_statement, Demo.Reports.CFStatement, on_replace: :nilify
    has_one :equity_statement, Demo.Reports.EquityStatement, on_replace: :nilify
  

    timestamps()
  end

  @fields [
    :gab_balance, 
    :family_code,
    :nationality,
    :auth_code,
    :address,
    :house_holder_name,
    :house_holder_email,
    :house_holder_supul_id,
    :grand_father_name,
    :grand_mother_name,
    :grand_father_in_law_name,
    :grand_mother_in_law_name,
    :father_name,
    :mother_name,
    :father_in_law_name,
    :mother_in_law_name,
    :husband_id,
    :husband_name,
    :wife_id,
    :wife_name,
    :sons,
    :dauthers,
    :grand_sons,
    :grand_dauthers,
    :relatives,
    :inmates,
    :grand_father_email,
    :grand_mother_email,
    :grand_father_in_law_email,
    :grand_mother_in_law_email,
    :father_email,
    :mother_email,
    :father_in_law_email,
    :mother_in_law_email,
    :husband_email,
    :wife_email,
    :entity_id_of_grand_father,
    :entity_id_of_grand_mother,
    :entity_id_of_grand_father_in_law,
    :entity_id_of_grand_mother_in_law,
    :entity_id_of_father,
    :entity_id_of_mother,
    :entity_id_of_father_in_law,
    :entity_id_of_mother_in_law,
    :entity_id_of_house_holder,
    :entity_id_of_husband,
    :entity_id_of_wife,
    :entity_id_of_sons,
    :entity_id_of_dauthers,
    :entity_id_of_grand_sons,
    :entity_id_of_grand_dauthers,
    :entity_id_of_relatives,
    :entity_id_of_inmates,
    :payload,
    :openhash_id, 
  ]



  def changeset(family, attrs = %{users: users}) do
    IO.puts "changeset(family, attrs = %{users: users})"
    family
    |> cast(attrs, @fields)
    |> put_assoc(:users, attrs.users)
  end

  def changeset(family, attrs = %{wedding: wedding}) do
    IO.puts "changeset(family, attrs = %{wedding: wedding})"
    family
    |> cast(attrs, @fields)
    |> put_assoc(:wedding, attrs.wedding)
  end
  
  def changeset(family, attrs = %{group: group}) do
    IO.puts "changeset(family, attrs = %{group: group})"
    family
    |> cast(attrs, @fields)
    |> put_assoc(:group, attrs.group)
  end

  def changeset(family, attrs = %{gab_balance: gab_balance}) do
    family
    |> cast(attrs, @fields)
  end
  
  def changeset(family, attrs) do
    family
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:account_book, attrs.ab)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
  end
  

  def changeset_auth(family, attrs = %{auth_code: auth_code, nation: nation, nationality: nation_name}) do
    family
    |> cast(attrs, @fields)
    |> put_assoc(:nation, nation)
  end
end
