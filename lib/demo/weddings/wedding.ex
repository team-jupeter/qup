defmodule Demo.Weddings.Wedding do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "weddings" do
    field :type, :string
    field :bride_id, :binary_id
    field :bride_name, :string
    field :bride_email, :string
    field :groom_id, :binary_id 
    field :groom_name, :string
    field :groom_email, :string
    field :erl_supul_id, :binary_id
    field :erl_supul_name, :string
    field :ssu_supul_id, :binary_id
    field :ssu_supul_name, :string
    field :event_hash, :string 

    field :erl_email, :string
    field :ssu_email, :string

    field :openhash_id, :binary_id
    field :payload, :string

    has_many :openhashes, Demo.Openhashes.Openhash
    belongs_to :family, Demo.Families.Family, type: :binary_id
    belongs_to :user, Demo.Accounts.User, type: :binary_id

    timestamps()
  end

  @fields [
    :type, 
    :bride_id, 
    :bride_name, 
    :bride_email, 
    :groom_id,  
    :groom_name,  
    :groom_email, 
    :erl_supul_id,  
    :erl_supul_name, 
    :ssu_supul_id, 
    :ssu_supul_name, 
    :event_hash, 
    :erl_email,
    :ssu_email,
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
