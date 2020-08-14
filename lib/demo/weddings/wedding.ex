defmodule Demo.Weddings.Wedding do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "weddings" do
    field :type, :string
    field :input_id, :binary_id
    field :input_name, :string
    field :input_email, :string
    field :output_id, :binary_id 
    field :output_name, :string
    field :output_email, :string
    field :input_supul_id, :binary_id
    field :input_supul_name, :string
    field :output_supul_id, :binary_id
    field :output_supul_name, :string
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
    :input_id, 
    :input_name, 
    :input_email, 
    :output_id,  
    :output_name,  
    :output_email, 
    :input_supul_id,  
    :input_supul_name, 
    :output_supul_id, 
    :output_supul_name, 
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
