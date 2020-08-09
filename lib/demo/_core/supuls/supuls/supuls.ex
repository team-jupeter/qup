defmodule Demo.Supuls do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  alias Demo.AccountBooks.AccountBook
  alias Demo.GabAccounts.GabAccount

  # alias Demo.FinancialReports
  # alias Demo.BalanceSheets
  # alias Demo.IncomeStatements
  # alias Demo.CFStatements
  # alias Demo.EquityStatements
  # alias Demo.AccountBooks
  # alias Demo.GabAccounts

  # alias Demo.Entities
  # alias Demo.Entities.Entity
  # alias Demo.StateSupuls
  # alias Demo.Openhashes.Openhash
  # alias Demo.NationSupuls.NationSupul
  # alias Demo.Openhashes.Openhash
  # alias Demo.Transactions

  def list_supuls do
    Repo.all(Supul)
  end

  def get_supul!(id), do: Repo.get!(Supul, id)
  def get_supul(id), do: Repo.get(Supul, id)

  def create_supul(attrs) do
    attrs = make_financial_statements(attrs)
    
    %Supul{}  
    |> Supul.changeset(attrs)
    |> Repo.insert()  
  end


  def minus_t1_balance(%Supul{} = supul, %{amount: amount}) do
    minus_t1_balance = Decimal.sub(supul.t1_balance, amount)
    update_supul_gab(supul, %{t1_balance: minus_t1_balance})
  end

  def plus_t1_balance(%Supul{} = supul, %{amount: amount}) do
    plus_t1_balance = Decimal.add(supul.t1_balance, amount)
    update_supul_gab(supul, %{t1_balance: plus_t1_balance})
  end

  defp make_financial_statements(attrs) do
    ab = %AccountBook{}
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}
    ga = %GabAccount{}

    Map.merge(attrs, %{ab: ab, is: is, bs: bs, cf: cf, es: es, fr: fr, ga: ga})
  end

  def update_openhash(%Supul{} = supul, attrs) do
    IO.puts "update_openhash"
    supul = Repo.preload(supul, :openhashes)
    supul
    |> Supul.changeset_openhash(attrs)
    |> Repo.update()
  end

  def update_openhash_box(%Supul{} = supul, attrs) do
    IO.puts "update_openhash_box"
    supul
    |> Supul.changeset_openhash_box(attrs)
    |> Repo.update()
  end

  def update_supul(%Supul{} = supul, attrs) do
    IO.puts "update_supul"
    supul
    |> Supul.changeset(attrs)
    |> Repo.update()
  end

  def update_supul_gab(%Supul{} = supul, attrs) do
    IO.puts "update_supul_gab"
    supul
    |> Supul.changeset_gab(attrs)
    |> Repo.update()
  end

  def update_hash_chain(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset_event_hash(attrs)
    |> Repo.update()
  end

  def delete_supul(%Supul{} = supul) do
    Repo.delete(supul)
  end

  def change_supul(%Supul{} = supul) do
    Supul.changeset(supul, %{})
  end

end
