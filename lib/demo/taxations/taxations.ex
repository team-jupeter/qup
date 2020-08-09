defmodule Demo.Taxations do
  @moduledoc """
  The Taxes context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Taxations.Taxation
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  # alias Demo.AccountBooks.AccountBook

  def list_taxations do
    Repo.all(Taxation)
  end

  def get_taxation!(id), do: Repo.get!(Taxation, id)

  def create_taxation(attrs \\ %{}) do
    attrs = make_financial_statements(attrs)

    %Taxation{}
    |> Taxation.changeset(attrs)
    |> Repo.insert()
  end

  defp make_financial_statements(attrs) do
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}

    Map.merge(attrs, %{is: is, bs: bs, cf: cf, es: es, fr: fr})
  end


  def update_taxation(%Taxation{} = taxation, attrs) do
    taxation
    |> Taxation.changeset(attrs)
    |> Repo.update()
  end

  def delete_taxation(%Taxation{} = taxation) do
    Repo.delete(taxation)
  end

  def change_taxation(%Taxation{} = taxation) do
    Taxation.changeset(taxation, %{})
  end
end
