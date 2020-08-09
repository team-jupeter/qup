defmodule Demo.GlobalSupuls.GlobalSupul do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.GlobalSupuls.GlobalSupul
  alias Demo.NationSupuls.NationSupul

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "global_supuls" do
    field :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0
    field :type, :string
    field :name, :string

    field :auth_code, :string
    field :hash_count, :integer, default: 0
    field :hash_chain, {:array, :string}, default: []
    field :openhash_box, {:array, :string}, default: []
    field :current_hash, :string
    field :incoming_hash, :string

    has_many :nation_supuls, Demo.NationSupuls.NationSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport

    timestamps()
  end

  @fields [
    :t1_balance,
    :name,
    :auth_code,
    :openhash_box,
    :current_hash,
    :incoming_hash,
    :hash_count
  ]

  def changeset(
        %GlobalSupul{} = global_supul,
        attrs = %{incoming_hash: incoming_hash, sender: sender}
      ) do
    previous_hash = global_supul.current_hash
    new_current_hash = Pbkdf2.hash_pwd_salt(global_supul.current_hash <> attrs.incoming_hash)
    # new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    new_hash =
      Pbkdf2.hash_pwd_salt(new_current_hash)
      |> Base.encode16()
      |> String.downcase()

    new_count = global_supul.hash_count + 1

    attrs = %{
      sender: attrs.sender,
      previous_hash: previous_hash,
      incoming_hash: incoming_hash,
      current_hash: new_hash,
      hash_count: new_count,
      hash_chain: [new_hash | global_supul.hash_chain]
    }

    global_supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def changeset_openhash(
        global_supul,
        attrs = %{openhash: openhash, supul_signature: supul_signature}
      ) do
    IO.puts("StateSupul openhash changeset")

    %NationSupul{}
    |> cast(attrs, @fields)
    |> put_assoc(:openhash, openhash)
  end

  @doc false
  def changeset_gab(global_supul, attrs) do
    global_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end

  @doc false
  def changeset(global_supul, attrs) do
    global_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])

    #   |> put_assoc(:account_book, attrs.ab)
    #   |> put_assoc(:income_statement, attrs.is)
    #   |> put_assoc(:balance_sheet, attrs.bs)
    #   |> put_assoc(:financial_report, attrs.fr)
    #   |> put_assoc(:cf_statement, attrs.cf)
    #   |> put_assoc(:equity_statement, attrs.es)
    # end
  end
end
