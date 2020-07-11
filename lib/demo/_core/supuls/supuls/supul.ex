defmodule Demo.Supuls.Supul do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Supuls.Supul
  alias Demo.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "supuls" do
    field :type, :string
    field :supul_code, :string
    field :geographical_area, :string
    field :name, :string
    field :state_name, :string
    field :nation_name, :string 

    field :auth_code, :string
    field :payload, :string
    field :payload_hash, :string

    field :hash_history, {:array, :string}, default: []
    field :current_hash, :string
    field :incoming_hash, :string

    has_many :entities, Demo.Business.Entity, on_replace: :nilify
    has_many :payloads, Demo.Mulets.Payload, on_replace: :nilify
    has_many :schools, Demo.Schools.School, on_replace: :nilify

    has_one :financial_report, Demo.Reports.FinancialReport, on_replace: :nilify
    # has_one :mulet, Demo.Mulets.Mulet
    has_one :gopang, Demo.Gopangs.Gopang 
    
    belongs_to :state_supul, Demo.StateSupuls.StateSupul, type: :binary_id

    timestamps()
  end

  @doc false
  @fields [
    :type, :name, :geographical_area, :supul_code, :auth_code, 
    :payload, :payload_hash, :state_name, :nation_name, 
    :hash_history, :current_hash, :incoming_hash
  ]

  def changeset(%Supul{} = supul, attrs = %{txn_id: txn_id, incoming_hash: incoming_hash}) do
    old_current_hash = supul.current_hash
    new_current_hash = Pbkdf2.hash_pwd_salt(supul.current_hash <> attrs.incoming_hash)
    
    # new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    new_hash = Pbkdf2.hash_pwd_salt(new_current_hash)
    |> Base.encode16()
    |> String.downcase()

    IO.inspect "new_hash"
    IO.inspect new_hash

    changeset(supul, %{hash_history: [old_current_hash | supul.hash_history], current_hash: new_hash})
    |> Repo.update!
  end

  def changeset(supul, attrs = %{hash_history: hash_history, current_hash: current_hash}) do
    supul
    |> cast(attrs, @fields)
    |> validate_required([])
    |> IO.inspect
  end

  def changeset(attrs = %{state_supul: state_supul}) do
    %Supul{}
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_assoc(:state_supul, attrs.state_supul)
  end

  def changeset(%Supul{} = supul, attrs = %{auth_code: auth_code}) do
    supul
    |> cast(attrs, @fields)
    |> validate_required([])
    |> put_change(:auth_code, attrs.auth_code)
  end

  def changeset(attrs) do
    %Supul{}
    |> cast(attrs, @fields)
    |> validate_required([])
  end


  def changeset(%Supul{} = supul, attrs) do
    supul
    |> cast(attrs, @fields)
    |> validate_required([])
  end

end
