defmodule Demo.Supuls.ProcessWedding do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.Families
  alias Demo.Accounts.User
  alias Demo.Business.Entity
  # alias Demo.Weddings
  alias Demo.Accounts
  alias Demo.Groups
  alias Demo.Supuls.Supul
  # alias Demo.Supuls
  alias Demo.Business

  def process_wedding(wedding) do
    attrs = %{
      house_holder_id: wedding.bride_id,
      house_holder_name: wedding.bride_name,
      house_holder_email: wedding.bride_email,
      husband_id: wedding.bride_id,
      husband_name: wedding.bride_name,
      wife_id: wedding.groom_id,
      wife_email: wedding.groom_email,
      wife_name: wedding.groom_name,
      house_holder_supul_id: wedding.erl_supul_id
    }

    wife = Repo.one(from u in User, where: u.id == ^wedding.groom_id, select: u)
    husband = Repo.one(from u in User, where: u.id == ^wedding.bride_id, select: u)

    {:ok, family} = Families.create_family(attrs)
    {:ok, family} = Repo.preload(family, :users) |> Families.update_family(%{users: [wife, husband]})

    {:ok, wife} = Repo.preload(wife, :family) |> Accounts.update_user(%{family: family})

    {:ok, husband} = Repo.preload(husband, :family) |> Accounts.update_user(%{family: family})
    
    wife_entity = Repo.one(from e in Entity, where: e.id == ^wife.default_entity_id, select: e)
    husband_entity = Repo.one(from e in Entity, where: e.id == ^husband.default_entity_id, select: e)
    
    #? combine the entities of lee ans sung together into one group to make a family financial reports. 
    {:ok, group} = Groups.create_group(%{type: "family", title: "이몽룡과 성춘향의 가족"})
    {:ok, group} = Repo.preload(group, :entities) |> Groups.update_group(%{entities: [husband_entity, wife_entity]})

    {:ok, family} = Repo.preload(family, :group) |> Families.update_family(%{group: group})
'''
    #? We should remove lee and sung from their previous families.
    #? but, they are the first family like Adam and Eve. 

    Families.delete_member(husband_previous_family, husband)
    Families.delete_member(wife_previous_family, wife)
'''
    #? change the supul of the new wife to that of the husband.
    # husband_supul = Repo.one(from s in Supul, where: s.id == ^wedding.erl_supul_id, select: s)
    # {:ok, wife} = Repo.preload(wife, :supul) |> Accounts.update_user(%{supul: husband_supul})
    {:ok, wife} = Accounts.update_user(wife, %{supul_id: wedding.erl_supul_id})
    {:ok, wife_entity} = Business.update_entity(wife_entity, %{supul_id: wedding.erl_supul_id})


    IO.inspect "wife"
    IO.inspect wife

    {:ok, family} = Repo.preload(family, :users) |> Families.update_family(%{users: [wife, husband]})

    #? change the supul of the entity of the new wife to that of the husband.
    # wife_entity = Repo.preload(wife_entity, :supul) |> Business.update_entity(%{supul: husband_entity.supul})

    IO.inspect "wife_entity"
    IO.inspect wife_entity

    IO.puts "Enum.at(Repo.preload(wife, :entities).entities, 0)"
    IO.inspect Enum.at(Repo.preload(wife, :entities).entities, 0)

    {:ok, family}
  end

  # defp update_family(wedding) do

  # end
end
