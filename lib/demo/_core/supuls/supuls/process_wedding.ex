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

  alias Demo.FinancialReports
  alias Demo.BalanceSheets
  alias Demo.AccountBooks
  alias Demo.IncomeStatements
  alias Demo.CFStatements
  alias Demo.EquityStatements

  def process_wedding(wedding, openhash) do
    groom = Repo.one(from u in User, where: u.id == ^wedding.groom_id, select: u)
    bride = Repo.one(from u in User, where: u.id == ^wedding.bride_id, select: u)

    groom_entity = Repo.one(from e in Entity, where: e.id == ^groom.default_entity_id, select: e)
    bride_entity = Repo.one(from e in Entity, where: e.id == ^bride.default_entity_id, select: e)

    bride = Repo.preload(bride, :supul)
    bride_supul = Repo.one(from s in Supul, where: s.id == ^bride.supul.id)

    groom = Repo.preload(groom, :supul)
    groom_supul = Repo.one(from s in Supul, where: s.id == ^groom.supul.id)

    # ? Create a family via wedding.
    {:ok, family} = Families.create_family_via_wedding(wedding, openhash, bride, groom)

    # ? Update the current marrige status and history, and supul_id etc. of users.
    Accounts.update_user(bride, %{
      wedding: wedding,
      married: true,
      supul_id: bride_supul.id,
      supul_name: bride_supul.name
    })

    Accounts.update_user(groom, %{
      wedding: wedding,
      married: true,
      supul_id: bride_supul.id,
      supul_name: bride_supul.name
    })

    # ? Update the supul_id etc. of users' entities.
    Entities.update_entity(bride_entity, %{supul_id: bride_supul.id, supul_name: bride_supul.name})

    Entities.update_entity(groom_entity, %{supul_id: bride_supul.id, supul_name: bride_supul.name})

    # ? create the account book of the family.
    AccountBooks.create_account_book(family)

    # ? create other financial statements of the family.
    BalanceSheets.create_balance_sheet(family)
    CFStatements.create_cf_statement(family)
    EquityStatements.create_equity_statement(family)
  end
end
