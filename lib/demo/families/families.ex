defmodule Demo.Families do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Families.Family

  def list_families do
    Repo.all(Family)
  end


  def get_family!(id), do: Repo.get!(Family, id)


 

  def create_family(attrs \\ %{}) do
    %Family{}
    |> Family.changeset(attrs)
    |> Repo.insert()
  end



  # def update_family_members(attrs, house_holder_rsa_priv_key, new_member_rsa_priv_key) do
  #   ts = DateTime.utc_now() |> DateTime.to_unix()
  
  #   attrs_serialized = Poison.encode!(attrs)
  #   # attrs_hash = Pbkdf2.hash_pwd_salt(attrs_serialized)
   
  #   attrs_msg = "#{ts}|#{attrs_serialized}"
  
  #   {:ok, house_holder_signature} = ExPublicKey.sign(attrs_msg, house_holder_rsa_priv_key)
  #   {:ok, new_member_signature} = ExPublicKey.sign(attrs_msg, new_member_rsa_priv_key)
  
  #   IO.puts "Hi, we have just married ...smile ^^*"
    
  #   family_payload = "#{
  #     ts}|#{attrs_serialized}|#{Base.url_encode64(house_holder_signature)}
  #     |#{Base.url_encode64(new_member_signature)}"

  # end

  def update_family(%Family{} = family, attrs) do   
    family
    |> Family.changeset(attrs)
    |> Repo.update()
  end

  def update_family_group(%Family{} = family, %{group: group}) do   
    family
    |> Family.changeset_group(%{group: group})
    |> Repo.update()
  end


  def delete_family(%Family{} = family) do
    Repo.delete(family)
  end


  def change_family(%Family{} = family) do
    Family.changeset(family, %{})
  end
end
