defmodule Demo.NationSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.NationSupuls.NationSupul
  alias Demo.Supuls.Supul
  alias Demo.Openhashes
  alias Demo.GlobalSupuls
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
  
  def list_nation_supuls do
    Repo.all(NationSupul)
  end
 

  def get_nation_supul!(id), do: Repo.get!(NationSupul, id)
  def get_nation_supul(id), do: Repo.get(NationSupul, id)

  def create_nation_supul(attrs) do
    attrs = make_financial_statements(attrs)

    %NationSupul{} 
    |> NationSupul.changeset(attrs)
    |> Repo.insert()
  end

  defp make_financial_statements(attrs) do 
    ab = %AccountBook{}
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}

    attrs = Map.merge(attrs, %{ab: ab, is: is, bs: bs, cf: cf, es: es, fr: fr})
  end

  
  def update_nation_supul(%NationSupul{} = nation_supul, %{
    incoming_hash: incoming_hash, sender: state_supul_id}) do

    make_hash(nation_supul, %{incoming_hash: incoming_hash, sender: state_supul_id})
    Openhashes.make_nation_openhash(nation_supul)

    if nation_supul.hash_count == 2, do: report_openhash_box_to_upper_supul(nation_supul)
  end

  defp make_hash(nation_supul, attrs) do
    Supul.changeset(nation_supul, attrs) 
    |> Repo.update!
  end


  defp report_openhash_box_to_upper_supul(nation_supul) do
    openhash_box_serialized = Poison.encode!(nation_supul.openhash_box)
    hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

    global_supul = Repo.preload(nation_supul, :global_supul).global_supul

    GlobalSupuls.update_global_supul(global_supul, %{
      incoming_hash: hash_of_openhash_box, sender: nation_supul.id})
   
   #? init supul for the next hash block. 
    NationSupul.changeset(nation_supul, %{
      hash_count: 1, openhash_box: []})
  end



  def update_nation_supul(nation_supul, attrs) do
    IO.puts "def update_nation_supul(nation_supul, attrs)"
    NationSupul.changeset(nation_supul, attrs) |> Repo.update()
  end

  def delete_nation_supul(%NationSupul{} = nation_supul) do
    Repo.delete(nation_supul)
  end

  def change_nation_supul(%NationSupul{} = nation_supul) do
    NationSupul.changeset(nation_supul, %{})
  end
end
