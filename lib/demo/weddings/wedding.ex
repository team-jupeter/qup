defmodule Demo.Weddings.Wedding do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "weddings" do
    field :type, :string
    field :erl_id, :binary_id
    field :erl_name, :string
    field :erl_email, :string
    field :ssu_id, :binary_id 
    field :ssu_name, :string
    field :ssu_email, :string
    field :erl_supul_id, :binary_id
    field :erl_supul_name, :string
    field :ssu_supul_id, :binary_id
    field :ssu_supul_name, :string
    field :event_hash, :string 

    field :openhash_id, :binary_id
    field :payload, :string

    has_many :openhashes, Demo.Openhashes.Openhash
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :user, Demo.Accounts.User, type: :binary_id

    timestamps()
  end

  @fields [
    :type, 
    :erl_id, 
    :erl_name, 
    :erl_email, 
    :ssu_id,  
    :ssu_name,  
    :ssu_email, 
    :erl_supul_id,  
    :erl_supul_name, 
    :ssu_supul_id, 
    :ssu_supul_name, 
    :event_hash, 
    :openhash_id,
    :payload, 
  ]
  @doc false
  def changeset(wedding, attrs) do
    wedding
    |> cast(attrs, @fields)
    |> validate_required([])
  end

   
  def changeset_openhash(wedding, attrs) do 
    # IO.puts "changeset_openhash"
    wedding = Demo.Repo.preload(wedding, :openhashes)

    IO.puts "wedding, changeset_openhash"
    openhashes = [attrs.openhash | wedding.openhashes]


    wedding
    |> cast(attrs, @fields)
    |> put_assoc(:openhashes, openhashes)
    # |> check_fair_trade(attrs)
  end
end
