defmodule Demo.Families do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Families.Family
  alias Demo.Families
  alias Demo.Accounts.User

  def get_user_family!(%User{} = user) do
    Repo.preload(user, :family).family
  end 

  def create_family_via_wedding(wedding, openhash, bride, groom) do
    '''
        #? Record wedding history of the bride and the groom.
    # Weddings.update_wedding(wedding, openhash)
    wedding = Repo.preload(lee_family, :wedding).wedding
    openhashes = Repo.preload(wedding, :openhashes).openhashes
'''
    #? Family attrs
    attrs = %{
      house_holder_id: wedding.bride_id,
      house_holder_name: wedding.bride_name,
      house_holder_email: wedding.bride_email,
      husband_id: wedding.bride_id,
      husband_name: wedding.bride_name,
      husband_email: wedding.bride_email,
      wife_id: wedding.groom_id,
      wife_name: wedding.groom_name,
      wife_email: wedding.groom_email, 
      house_holder_supul_id: wedding.erl_supul_id
    }

 
'''  
    #? We should remove lee and sung from their previous families.
    #? but, at this time, they are the first family like Adam and Eve. 

    Families.delete_member(husband_previous_family, husband)
    Families.delete_member(wife_previous_family, wife)
'''
    #? Return family
    {:ok, family} = %Family{}
      |> Family.changeset(attrs)
      |> Repo.insert()

    {:ok, family} = Repo.preload(family, :users) |> Families.update_family(%{users: [bride, groom]})
    
    IO.puts "Repo.preload(family, :wedding |> Families.update_family(%{wedding: wedding}))"
    {:ok, family} = Repo.preload(family, :wedding) |> Families.update_family(%{wedding: wedding})
    
    # {:ok, wife} = Repo.preload(wife, :family) |> Accounts.update_user(%{family: family})
    # {:ok, husband} = Repo.preload(husband, :family) |> Accounts.update_user(%{family: family})
  end

  def update_family_group(%Family{} = family, %{group: group}) do   
    family
    |> Family.changeset_group(%{group: group})
    |> Repo.update()
  end 

  def update_family(%Family{} = family, attrs) do  
    IO.puts "update_family(%Family{} = family, attrs)"
    family
    |> Family.changeset(attrs) 
    |> Repo.update() 
    |> IO.inspect
  end


  def delete_family(%Family{} = family) do
    Repo.delete(family)
  end


  def change_family(%Family{} = family) do
    Family.changeset(family, %{})
  end

  def new_family(%Family{} = family) do
    Family.changeset(family, %{}) 
  end
end
