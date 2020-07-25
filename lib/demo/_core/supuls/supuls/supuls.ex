defmodule Demo.Supuls do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul
  alias Demo.FinancialReports
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.CFStatements
  alias Demo.EquityStatements

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

  def create_supul(attrs) do
    {:ok, supul} = Supul.changeset(attrs) |> Repo.insert()

    # ? Create financial statements for the supul.
    IncomeStatements.create_income_statement(supul)
    FinancialReports.create_financial_report(supul)

    BalanceSheets.create_balance_sheet(supul)
    CFStatements.create_cf_statement(supul)
    EquityStatements.create_equity_statement(supul)


    {:ok, supul}
  end

  def update_supul(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset(attrs)
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

  defp create_financial_report(supul) do
    entities = Repo.preload(supul, :entities).entities

    list_FR =
      Enum.map(entities, fn entity -> Repo.preload(entity, :financial_report).financial_report end)

    num_of_shares =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.num_of_shares, acc)
      end)

    num_of_shares_issued =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.num_of_shares_issued, acc)
      end)

    num_of_treasury_stocks =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.num_of_treasury_stocks, acc)
      end)

    market_capitalization =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.market_capitalization, acc)
      end)

    stock_price =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.stock_price, acc)
      end)

    intrinsic_value =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.intrinsic_value, acc)
      end)

    re_fmv =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.re_fmv, acc) end)

    debt_int_rate =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.debt_int_rate, acc)
      end)

    attrs = %{
      num_of_shares: num_of_shares,
      num_of_shares_issued: num_of_shares_issued,
      num_of_treasury_stocks: num_of_treasury_stocks,
      market_capitalization: market_capitalization,
      stock_price: stock_price,
      intrinsic_value: intrinsic_value,
      re_fmv: re_fmv,
      debt_int_rate: debt_int_rate
    }

    FinancialReports.create_financial_report(supul, attrs)
  end

  defp create_balance_sheet(supul) do
    entities = Repo.preload(supul, :entities).entities

    list_BS =
      Enum.map(entities, fn entity -> Repo.preload(entity, :balance_sheet).balance_sheet end)

    accounts_payable =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.accounts_payable, acc)
      end)

    accounts_receivable =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.accounts_receivable, acc)
      end)

    accrued_liabilities =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.accrued_liabilities, acc)
      end)

    additional_paid_in_capital =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.additional_paid_in_capital, acc)
      end)

    cash =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.cash, acc) end)

    customer_prepayments =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.customer_prepayments, acc)
      end)

    fixed_assets =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.fixed_assets, acc)
      end)

    inventory =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.inventory, acc)
      end)

    long_term_debt =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.long_term_debt, acc)
      end)

    marketable_securities =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.marketable_securities, acc)
      end)

    prepaid_expenses =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.prepaid_expenses, acc)
      end)

    retained_earnings =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.retained_earnings, acc)
      end)

    short_term_debt =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.short_term_debt, acc)
      end)

    stock =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.stock, acc) end)

    taxes =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.taxes, acc) end)

    treasury_stock =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.treasury_stock, acc)
      end)

    gab_balance =
      Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.gab_balance, acc)
      end)

    attrs = %{
      accounts_payable: accounts_payable,
      accounts_receivable: accounts_receivable,
      accrued_liabilities: accrued_liabilities,
      additional_paid_in_capital: additional_paid_in_capital,
      cash: cash,
      customer_prepayments: customer_prepayments,
      fixed_assets: fixed_assets,
      inventory: inventory,
      long_term_debt: long_term_debt,
      marketable_securities: marketable_securities,
      prepaid_expenses: prepaid_expenses,
      retained_earnings: retained_earnings,
      short_term_debt: short_term_debt,
      stock: stock,
      taxes: taxes,
      treasury_stock: treasury_stock,
      gab_balance: gab_balance
    }

    BalanceSheets.create_balance_sheet(supul, attrs)
  end

  defp create_cf_statement(supul) do
    entities = Repo.preload(supul, :entities).entities

    list_CF =
      Enum.map(entities, fn entity -> Repo.preload(entity, :cf_statement).cf_statement end)

    capital_expenditures =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.capital_expenditures, acc)
      end)

    changes_in_working_capital =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.changes_in_working_capital, acc)
      end)

    debt_issuance =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.debt_issuance, acc)
      end)

    depreciation_amortization =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.depreciation_amortization, acc)
      end)

    equity_issuance =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.equity_issuance, acc)
      end)

    net_earnings =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.net_earnings, acc)
      end)

    opening_cash_balance =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.opening_cash_balance, acc)
      end)

    attrs = %{
      capital_expenditures: capital_expenditures,
      changes_in_working_capital: changes_in_working_capital,
      debt_issuance: debt_issuance,
      depreciation_amortization: depreciation_amortization,
      equity_issuance: equity_issuance,
      net_earnings: net_earnings,
      opening_cash_balance: opening_cash_balance
    }

    CFStatements.create_cf_statement(supul, attrs)
  end

  defp create_equity_statement(supul) do
    entities = Repo.preload(supul, :entities).entities

    list_ES =
      Enum.map(entities, fn entity -> Repo.preload(entity, :equity_statement).equity_statement end)

    opening_balance =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.opening_balance, acc)
      end)

    net_income =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.net_income, acc)
      end)

    other_income =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_income, acc)
      end)

    issue_of_new_capital =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.issue_of_new_capital, acc)
      end)

    net_loss =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.net_loss, acc) end)

    other_loss =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_loss, acc)
      end)

    dividends =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.dividends, acc)
      end)

    withdrawal_of_capital =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.withdrawal_of_capital, acc)
      end)

    attrs = %{
      opening_balance: opening_balance,
      net_income: net_income,
      other_income: other_income,
      issue_of_new_capital: issue_of_new_capital,
      net_loss: net_loss,
      other_loss: other_loss,
      dividends: dividends,
      withdrawal_of_capital: withdrawal_of_capital
    }

    EquityStatements.create_equity_statement(supul, attrs)
  end
end
