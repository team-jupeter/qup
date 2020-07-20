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
    field :ssu_supul_id, :binary_id
    field :event_hash, :string 

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
    :ssu_supul_id, 
    :event_hash, 
  ]
  @doc false
  def changeset(wedding, attrs) do
    wedding
    |> cast(attrs, @fields)
    |> validate_required([])
  end

   
  def changeset_openhash(wedding, attrs) do 
    wedding
    |> cast(attrs, @fields)
    |> put_assoc(:openhash, attrs.openhash)
    # |> check_fair_trade(attrs)
  end
end
