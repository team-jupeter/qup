defmodule Demo.Supuls.ProcessWedding do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.Families
  alias Demo.Accounts.User
  alias Demo.Entities.Entity
  # alias Demo.Weddings
  alias Demo.Accounts
  alias Demo.Groups
  alias Demo.Supuls.Supul
  # alias Demo.Supuls
  alias Demo.Entities
  alias Demo.Weddings
  alias Demo.Accounts
  alias Demo.Families

  def process_wedding(wedding, openhash) do
    groom = Repo.one(from u in User, where: u.id == ^wedding.groom_id, select: u)
    bride = Repo.one(from u in User, where: u.id == ^wedding.bride_id, select: u)
    
    groom_entity = Repo.one(from e in Entity, where: e.id == ^groom.default_entity_id, select: e)
    bride_entity = Repo.one(from e in Entity, where: e.id == ^bride.default_entity_id, select: e)
    
    bride = Repo.preload(bride, :supul)
    bride_supul = Repo.one(from s in Supul, where: s.id == ^bride.supul.id)
    
    groom = Repo.preload(groom, :supul)
    groom_supul = Repo.one(from s in Supul, where: s.id == ^groom.supul.id)
    

    #? Update the current marrige status and history, and supul_id etc. of users.
    Accounts.update_user(bride, %{wedding: wedding, married: true, supul_id: bride_supul.id, supul_name: bride_supul.name})
    Accounts.update_user(groom, %{wedding: wedding, married: true, supul_id: bride_supul.id, supul_name: bride_supul.name})
    
    #? Update the supul_id etc. of users' entities.
    Entities.update_entity(bride_entity, %{supul_id: bride_supul.id, supul_name: bride_supul.name})
    Entities.update_entity(groom_entity, %{supul_id: bride_supul.id, supul_name: bride_supul.name})
  
    #? Create a family group.
    {:ok, group} = Groups.create_group(%{type: "family", title: "이몽룡과 성춘향의 가족"})
    Repo.preload(group, :entities) |> Groups.update_group(%{entities: [groom_entity, bride_entity]})

    #? Create a family via wedding.
    Families.create_family_via_wedding(wedding, openhash, bride, groom)

  end




  # defp update_family(wedding) do


    # end
end