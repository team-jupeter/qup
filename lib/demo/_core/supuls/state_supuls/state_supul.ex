defmodule Demo.StateSupuls.StateSupul do
  use Ecto.Schema
  import Ecto.Changeset 
  alias Demo.StateSupuls.StateSupul

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "state_supuls" do
    field :type, :string 
    field :state_supul_code, :string
    field :name, :string
    field :nation_name, :string

    field :auth_code, :string

    field :hash_count, :integer, default: 0
    
    field :sender, :binary_id 
    field :hash_chain, {:array, :string}, default: [] 
    field :openhash_box, {:array, :string}, default: [] 
    field :current_hash, :string, default: "state_supul origin"
    field :incoming_hash, :string
    field :previous_hash, :string
    field :nation_openhash_id, :binary_id, default: "b87dc547-649b-41cb-9e17-d83977753abc"

    has_many :supuls, Demo.Supuls.Supul
    has_many :schools, Demo.Schools.School, on_replace: :nilify
    has_many :openhashes, Demo.Openhashes.Openhash, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport 

    belongs_to :nation_supul, Demo.NationSupuls.NationSupul, type: :binary_id
    
    timestamps()
  end

  @fields [
    :type, :name, :nation_name, :auth_code, :state_supul_code, :hash_chain,
    :openhash_box, :current_hash, :incoming_hash, :hash_count, :nation_openhash_id,
    :previous_hash, :sender, 
  ]

  def changeset(%StateSupul{} = state_supul, attrs = %{
    incoming_hash: incoming_hash, sender: sender}) do
    previous_hash = state_supul.current_hash

    new_current_hash = Pbkdf2.hash_pwd_salt(state_supul.current_hash <> attrs.incoming_hash)
    # new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    |> Base.encode16()
    |> String.downcase()   
    
    new_count = state_supul.hash_count + 1

    attrs = %{
      sender: attrs.sender,
      previous_hash: previous_hash,
      incoming_hash: incoming_hash,
      current_hash: new_hash,
      hash_count: new_count,
      hash_chain: [new_hash | state_supul.hash_chain]
    }

    state_supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end
  
  def changeset_openhash(state_supul, attrs = %{openhash: openhash}) do
    IO.puts "StateSupul openhash changeset"
    state_supul = Demo.Repo.preload(state_supul, :openhashes)
    state_supul
    |> cast(attrs, @fields)
    |> put_assoc(:openhashes, [openhash | state_supul.openhashes])
  end 

  def changeset(state_supul, attrs = %{nation_supul: nation_supul}) do
    IO.puts "StateSupul nation_supul changeset"
    state_supul
    |> cast(attrs, @fields)
    |> put_assoc(:nation_supul, attrs.nation_supul)
  end 
  @doc false
  def changeset(attrs) do
    %StateSupul{}
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end

  def changeset(%StateSupul{} = state_supul, attrs = %{auth_code: auth_code}) do
    state_supul
    |> cast(attrs, @fields)
    |> validate_required([:name])
    |> put_change(:auth_code, attrs.auth_code)
  end

  def changeset(%StateSupul{} = state_supul, attrs) do
    # IO.puts "StateSupul changeset"
    state_supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end
end
