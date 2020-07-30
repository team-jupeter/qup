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
  alias Demo.Families.Family

  alias Demo.FinancialReports
  alias Demo.BalanceSheets
  alias Demo.AccountBooks
  alias Demo.IncomeStatements
  alias Demo.CFStatements
  alias Demo.EquityStatements

  def process_wedding(wedding) do
    bride = Repo.one(from u in User, where: u.id == ^wedding.erl_id, select: u)
    groom = Repo.one(from u in User, where: u.id == ^wedding.ssu_id, select: u)

    #? If any of groom and bride already married, stop the process.
    # any_family_1 = Repo.one(from f in Family, where: f.husband_id == ^groom.id or f.husband_id == ^groom.id, select: f)  
    # any_family_2 = Repo.one(from f in Family, where: f.husband_id == ^bride.id or f.husband_id == ^bride.id, select: f)  

    # if any_family_1 != nil or any_family_2 != nil, do: "error"

    #? process wedding
    groom_entity = Repo.one(from e in Entity, where: e.id == ^groom.default_entity_id, select: e)
    bride_entity = Repo.one(from e in Entity, where: e.id == ^bride.default_entity_id, select: e)

    bride = Repo.preload(bride, :supul)
    bride_supul = Repo.one(from s in Supul, where: s.id == ^bride.supul.id)

    groom = Repo.preload(groom, :supul)
    groom_supul = Repo.one(from s in Supul, where: s.id == ^groom.supul.id)

    # ? Create a family via wedding.
    {:ok, family} = Families.create_family_via_wedding(wedding, bride, groom)
    
    # ? Update the current marrige status and history, and supul_id etc. of users.
    Accounts.update_user_wedding(bride, %{
      family: family,
      wedding: wedding,
      married: true,
      supul: bride_supul,
    })
 
    Accounts.update_user_wedding(groom, %{
      family: family,
      wedding: wedding,
      married: true,
      supul: bride_supul,
    })

    # ? Update the supul_id etc. of users' entities.
    Entities.update_entity(bride_entity, %{
      family: family,
      supul: bride_supul, 
      })

    Entities.update_entity(groom_entity, %{
      family: family,
      supul: bride_supul, 
      })
  end
end
