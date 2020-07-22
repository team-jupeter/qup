defmodule Demo.NationSupuls.NationSupul do
  use Ecto.Schema
  import Ecto.Changeset

  alias Demo.NationSupuls.NationSupul

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "nation_supuls" do
    field :name, :string
    field :type, :string 
    field :nation_supul_code, :string

    field :auth_code, :string

    field :hash_count, :integer, default: 0

    field :hash_chain, {:array, :string}, default: []
    field :openhash_box, {:array, :string}, default: []
    field :current_hash, :string, default: "nation_supul origin"
    field :incoming_hash, :string
    field :previous_hash, :string
    field :global_openhash_id, :binary_id, default: "b87dc547-649b-41cb-9e17-d83977753abc"
    field :sender, :binary_id

    # has_many :entities, Demo.Entities.Entity
    has_many :state_supuls, Demo.StateSupuls.StateSupul
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    belongs_to :global_supul, Demo.GlobalSupuls.GlobalSupul, type: :binary_id
    has_one :financial_report, Demo.Reports.FinancialReport

    timestamps()
  end

  @fields [
    :name, :auth_code, :nation_supul_code, :type, :hash_chain,
    :openhash_box, :current_hash, :incoming_hash, :hash_count, :global_openhash_id,
    :previous_hash, :sender,  

  ]

  def changeset(%NationSupul{} = nation_supul, attrs = %{
    incoming_hash: incoming_hash, sender: state_supul_id}) do
    previous_hash = nation_supul.current_hash
    new_current_hash = Pbkdf2.hash_pwd_salt(nation_supul.current_hash <> attrs.incoming_hash)
    # new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    |> Base.encode16()
    |> String.downcase()   
    
    new_count = nation_supul.hash_count + 1

    attrs = %{
      sender: attrs.sender,
      previous_hash: previous_hash,
      incoming_hash: incoming_hash,
      current_hash: new_hash,
      hash_count: new_count,
      hash_chain: [new_hash | nation_supul.hash_chain]
    }

    nation_supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end
  
  def changeset_openhash(nation_supul, attrs = %{openhash: openhash, supul_signature: supul_signature}) do
    IO.puts "StateSupul openhash changeset"
    %NationSupul{}
    |> cast(attrs, @fields)
    |> put_assoc(:openhash, openhash)
  end 

  @doc false 
  def changeset(attrs = %{global_supul: global_supul}) do
    %NationSupul{}
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_assoc(:global_supul, attrs.global_supul)
  end

  def changeset(attrs) do
    %NationSupul{}
    |> cast(attrs, @fields)
    |> validate_required([])
  end

  def changeset(%NationSupul{} = nation_supul, attrs = %{auth_code: auth_code}) do
    nation_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_change(:auth_code, attrs.auth_code)
  end

  def changeset(%NationSupul{} = nation_supul, attrs) do
    nation_supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
