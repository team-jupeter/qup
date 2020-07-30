defmodule Demo.Families do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Families.Family
  alias Demo.Families
  alias Demo.Accounts.User
  alias Demo.Nations
  alias Demo.Nations.Nation
  alias Demo.Entities.Entity
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  alias Demo.AccountBooks.AccountBook


  def get_user_family!(%User{} = user) do
    Repo.preload(user, :family).family
  end 

  def get_family_entity(%Entity{} = entity) do
    Repo.preload(entity, :family).family
  end

 
  def get_family!(id), do: Repo.get!(Family, id)
  def get_family(id), do: Repo.get(Family, id)
  
  def create_family(attrs) do
    attrs = make_default_financial_statements(attrs)

    %Family{}
    |> Family.changeset(attrs)
    |> Repo.insert()
  end  

  defp make_default_financial_statements(attrs) do
    ab = %AccountBook{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}

    attrs = Map.merge(attrs, %{ab: ab, bs: bs, cf: cf, es: es, fr: fr})
  end

  def create_family_via_wedding(wedding, bride, groom) do
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

    #? Return family
    {:ok, family} = Families.create_family(attrs)
    {:ok, family} = Repo.preload(family, :users) |> Families.update_family(%{users: [bride, groom]})
    {:ok, family} = Repo.preload(family, :wedding) |> Families.update_family(%{wedding: wedding})

    #? Authorization from the nation
    nation = Repo.one(from n in Nation, where: n.id == ^bride.nation_id)

    #? hard_coded Korea' private key
    auth_code = Nations.authorize(nation, family)
    family = Repo.preload(family, :nation)

    family
    |> Family.changeset_auth(%{auth_code: auth_code, nation: nation, nationality: nation.name})
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
