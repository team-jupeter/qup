defmodule Demo.StateSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls
  # alias Demo.Supuls.Supul
  # alias Demo.Supuls
  alias Demo.Openhashes.Openhash
  alias Demo.Openhashes
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  alias Demo.AccountBooks.AccountBook
  alias Demo.FinancialReports
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.CFStatements
  alias Demo.EquityStatements
  alias Demo.AccountBooks
  alias Demo.GabAccounts.GabAccount
  alias Demo.GabAccounts

  def list_state_supuls do
    Repo.all(StateSupul) 
  end


  def get_state_supul!(id), do: Repo.get!(StateSupul, id)
  def get_state_supul(id), do: Repo.get(StateSupul, id)
 

  def create_state_supul(attrs) do
    attrs = make_financial_statements(attrs)

    %StateSupul{} 
    |> StateSupul.changeset(attrs)
    |> Repo.insert()
  end
 
  def minus_gab_balance(%StateSupul{} = state_supul, %{amount: amount}) do
    minus_gab_balance = Decimal.sub(state_supul.gab_balance, amount)
    update_state_supul_gab(state_supul, %{gab_balance: minus_gab_balance})
  end

  def plus_gab_balance(%StateSupul{} = state_supul, %{amount: amount}) do
    plus_gab_balance = Decimal.add(state_supul.gab_balance, amount)
    update_state_supul_gab(state_supul, %{gab_balance: plus_gab_balance})
  end

  defp make_financial_statements(attrs) do
    ab = %AccountBook{}
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}
    ga = %GabAccount{}

    attrs = Map.merge(attrs, %{ab: ab, is: is, bs: bs, cf: cf, es: es, fr: fr, ga: ga})  
  end
 
 
  def update_state_supul(%StateSupul{} = state_supul, %{
    incoming_hash: incoming_hash, sender: supul_id}) do
    make_hash(state_supul, %{incoming_hash: incoming_hash, sender: supul_id})
    Openhashes.make_state_openhash(state_supul)

    if state_supul.hash_count == 2, do: report_openhash_box_to_upper_supul(state_supul)
  end
 
  def update_state_supul_gab(%StateSupul{} = state_supul, attrs) do
    state_supul
    |> StateSupul.changeset_gab(attrs)
    |> Repo.update()
  end

  defp make_hash(state_supul, %{incoming_hash: incoming_hash, sender: supul_id}) do
    StateSupul.changeset(state_supul, %{incoming_hash: incoming_hash, sender: state_supul.id}) 
    |> Repo.update!
  end


  defp report_openhash_box_to_upper_supul(state_supul) do
    openhash_box_serialized = Poison.encode!(state_supul.openhash_box)
    hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

    nation_supul = Repo.preload(state_supul, :nation_supul).nation_supul

    NationSupuls.update_nation_supul(nation_supul, %{
      incoming_hash: hash_of_openhash_box, sender: state_supul.id})
   
   #? init supul for the next hash block. 
    StateSupul.changeset(state_supul, %{
      hash_count: 1, openhash_box: []})
  end


  # end

  def update_state_supul(state_supul, attrs) do
    StateSupul.changeset(state_supul, attrs) 
    |> Repo.update()
  end

  def change_state_supul(%StateSupul{} = state_supul) do
    StateSupul.changeset(state_supul, %{})
  end
end
