defmodule Demo.NationSupuls do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.NationSupuls.NationSupul
  # alias Demo.Supuls.Supul
  alias Demo.Openhashes
  alias Demo.GlobalSupuls
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  alias Demo.AccountBooks.AccountBook
  # alias Demo.FinancialReports
  # alias Demo.BalanceSheets
  # alias Demo.IncomeStatements
  # alias Demo.CFStatements
  # alias Demo.EquityStatements
  # alias Demo.AccountBooks
  alias Demo.GabAccounts.GabAccount
  # alias Demo.GabAccounts

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

  def minus_t1_balance(%NationSupul{} = nation_supul, %{amount: amount}) do
    minus_t1_balance = Decimal.sub(nation_supul.t1_balance, amount)
    update_nation_supul_gab(nation_supul, %{t1_balance: minus_t1_balance})
  end

  def plus_t1_balance(%NationSupul{} = nation_supul, %{amount: amount}) do
    plus_t1_balance = Decimal.add(nation_supul.t1_balance, amount)
    update_nation_supul_gab(nation_supul, %{t1_balance: plus_t1_balance})
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

  def update_nation_supul(%NationSupul{} = nation_supul, %{
        incoming_hash: incoming_hash,
        sender: state_supul_id
      }) do
    make_hash(nation_supul, %{incoming_hash: incoming_hash, sender: state_supul_id})
    Openhashes.make_nation_openhash(nation_supul)

    if nation_supul.hash_count == 100, do: report_openhash_box_to_upper_supul(nation_supul)
  end

  def update_nation_supul(%NationSupul{} = nation_supul, attrs) do
    nation_supul
    |> NationSupul.changeset(attrs)
    |> Repo.update()
  end

  def update_nation_supul_gab(%NationSupul{} = nation_supul, attrs) do
    nation_supul
    |> NationSupul.changeset_gab(attrs)
    |> Repo.update()
  end

  defp make_hash(nation_supul, attrs) do
    NationSupul.changeset(nation_supul, attrs)
    |> Repo.update!()
  end

  defp report_openhash_box_to_upper_supul(nation_supul) do
    openhash_box_serialized = Poison.encode!(nation_supul.openhash_box)
    hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

    global_supul = Repo.preload(nation_supul, :global_supul).global_supul

    GlobalSupuls.update_global_supul(global_supul, %{
      incoming_hash: hash_of_openhash_box,
      sender: nation_supul.id
    })

    # ? init supul for the next hash block. 
    NationSupul.changeset(nation_supul, %{hash_count: 1, openhash_box: []})
  end

  def delete_nation_supul(%NationSupul{} = nation_supul) do
    Repo.delete(nation_supul)
  end

  def change_nation_supul(%NationSupul{} = nation_supul) do
    NationSupul.changeset(nation_supul, %{})
  end
end
