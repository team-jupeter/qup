defmodule Demo.Families do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Families.Family
  alias Demo.Families
  alias Demo.Accounts.User
  alias Demo.Nations
  alias Demo.Nations.Nation

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
      house_holder_id: bride.id,
      house_holder_name: bride.name,
      house_holder_email: bride.email,
      husband_id: bride.id,
      husband_name: bride.name,
      husband_email: bride.email,
      wife_id: groom.id,
      wife_name: groom.name,
      wife_email: groom.email, 
      house_holder_supul_id: wedding.erl_supul_id,
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
    
    #? Authorization from the nation
    bride = Repo.preload(bride, :nation)
    nation = Repo.one(from n in Nation, where: n.id == ^bride.nation.id)

    #? hard_coded Korea' private key
    auth_code = Nations.authorize(nation, family)
    family = Repo.preload(family, :nation)
    family
    |> Family.changeset_auth(%{auth_code: auth_code, nation: nation, nationality: nation.name})
    |> Repo.update()  
    # {:ok, wife} = Repo.preload(wife, :family) |> Accounts.update_user(%{family: family})
    # {:ok, husband} = Repo.preload(husband, :family) |> Accounts.update_user(%{family: family})

  end


  def update_family(%Family{} = family, %{group: group}) do   
    IO.puts "update_family(%Family{} = family, attrs)"
  
    family = Repo.preload(family,:group)
    family
    |> Family.changeset(%{group: group})
    |> Repo.update()
  end 

  def update_family(%Family{} = family, attrs) do  
    family
    |> Family.changeset(attrs) 
    |> Repo.update() 
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
