defmodule Demo.Supuls.Supul do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Supuls.Supul
  # alias Demo.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "supuls" do
    field :type, :string
    field :supul_code, :string
    field :supul_name, :string
    field :geographical_area, :string
    field :name, :string
    field :state_name, :string
    field :nation_name, :string

    field :auth_code, :string

    field :hash_count, :integer, default: 0

    field :event_id, :binary_id
    field :event_sender, :string
    field :hash_chain, {:array, :string}, default: []
    field :openhash_box, {:array, :string}, default: []
    field :current_hash, :string, default: "state supul origin"
    field :incoming_hash, :string
    field :previous_hash, :string
    field :state_openhash_id, :binary_id, default: "b87dc547-649b-41cb-9e17-d83977753abc"

    has_many :entities, Demo.Entities.Entity, on_replace: :nilify
    has_many :payloads, Demo.Mulets.Payload, on_replace: :nilify
    has_many :schools, Demo.Schools.School, on_replace: :nilify
    has_many :openhashes, Demo.Openhashes.Openhash, on_replace: :nilify
    has_many :families, Demo.Families.Family, on_replace: :nilify

    has_one :account_book, Demo.AccountBooks.AccountBook
    has_one :financial_report, Demo.Reports.FinancialReport, on_replace: :nilify
    has_one :income_statement, Demo.Reports.IncomeStatement, on_replace: :nilify
    has_one :balance_sheet, Demo.Reports.BalanceSheet, on_replace: :nilify
    has_one :cf_statement, Demo.Reports.CFStatement, on_replace: :nilify
    has_one :equity_statement, Demo.Reports.EquityStatement, on_replace: :nilify
    # has_one :mulet, Demo.Mulets.Mulet
    has_one :gopang, Demo.Gopangs.Gopang

    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id

    timestamps()
  end

  @doc false
  @fields [
    :type,
    :name,
    :geographical_area,
    :supul_code,
    :auth_code,
    :state_name,
    :nation_name,
    :openhash_box,
    :hash_chain,
    :previous_hash,
    :current_hash,
    :incoming_hash,
    :hash_count,
    :event_id,
    :state_openhash_id,
    :event_id,
    :event_sender,
    :supul_name
  ]

  def changeset_event_hash(
        %Supul{} = supul,
        attrs = %{event_sender: sender, event_id: event_id, incoming_hash: incoming_hash}
      ) do
    previous_hash = supul.current_hash
    new_current_hash = Pbkdf2.hash_pwd_salt(supul.current_hash <> attrs.incoming_hash)
    # new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    new_hash =
      Pbkdf2.hash_pwd_salt(new_current_hash)
      |> Base.encode16()
      |> String.downcase()
 
    new_count = supul.hash_count + 1

    attrs = %{
      event_id: attrs.event_id,
      event_sender: attrs.event_sender,
      previous_hash: previous_hash,
      incoming_hash: incoming_hash,
      current_hash: new_hash,
      hash_count: new_count,
      hash_chain: [new_hash | supul.hash_chain]
    }

    supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def changeset_openhash(%Supul{} = supul, attrs = %{openhash: openhash}) do
    openhashes = [openhash | supul.openhashes]
    supul
    |> cast(attrs, @fields)
    |> put_assoc(:openhashes, openhashes)
  end
  def changeset_openhash_box(%Supul{} = supul, attrs = %{openhash_box: openhash_box}) do
    supul
    |> cast(attrs, @fields)
  end 

  # def changeset(attrs = %{state_supul: state_supul}) do
  #   %Supul{}
  #   |> cast(attrs, @fields)
  #   |> validate_required([])
  #   |> put_assoc(:state_supul, attrs.state_supul)
  # end

  def changeset(%Supul{} = supul, attrs = %{auth_code: auth_code}) do
    supul
    |> cast(attrs, @fields)
  end

  def changeset(%Supul{} = supul, attrs) do
    %Supul{}
    |> cast(attrs, @fields)
    |> put_assoc(:account_book, attrs.ab)
    |> put_assoc(:income_statement, attrs.is)
    |> put_assoc(:balance_sheet, attrs.bs)
    |> put_assoc(:financial_report, attrs.fr)
    |> put_assoc(:cf_statement, attrs.cf)
    |> put_assoc(:equity_statement, attrs.es)
  end
end
