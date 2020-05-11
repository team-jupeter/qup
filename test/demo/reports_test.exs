defmodule Demo.ReportsTest do
  use Demo.DataCase

  alias Demo.Reports

  describe "reports" do
    alias Demo.Reports.Report

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def report_fixture(attrs \\ %{}) do
      {:ok, report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_report()

      report
    end

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Reports.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Reports.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      assert {:ok, %Report{} = report} = Reports.create_report(@valid_attrs)
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      assert {:ok, %Report{} = report} = Reports.update_report(report, @update_attrs)
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_report(report, @invalid_attrs)
      assert report == Reports.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Reports.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Reports.change_report(report)
    end
  end

  describe "assets" do
    alias Demo.Reports.BalanceSheet

    @valid_attrs %{debt: "some debt", equity: "some equity"}
    @update_attrs %{debt: "some updated debt", equity: "some updated equity"}
    @invalid_attrs %{debt: nil, equity: nil}

    def balance_sheet_fixture(attrs \\ %{}) do
      {:ok, balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_balance_sheet()

      balance_sheet
    end

    test "list_assets/0 returns all assets" do
      balance_sheet = balance_sheet_fixture()
      assert Reports.list_assets() == [balance_sheet]
    end

    test "get_balance_sheet!/1 returns the balance_sheet with given id" do
      balance_sheet = balance_sheet_fixture()
      assert Reports.get_balance_sheet!(balance_sheet.id) == balance_sheet
    end

    test "create_balance_sheet/1 with valid data creates a balance_sheet" do
      assert {:ok, %BalanceSheet{} = balance_sheet} = Reports.create_balance_sheet(@valid_attrs)
      assert balance_sheet.debt == "some debt"
      assert balance_sheet.equity == "some equity"
    end

    test "create_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_balance_sheet(@invalid_attrs)
    end

    test "update_balance_sheet/2 with valid data updates the balance_sheet" do
      balance_sheet = balance_sheet_fixture()
      assert {:ok, %BalanceSheet{} = balance_sheet} = Reports.update_balance_sheet(balance_sheet, @update_attrs)
      assert balance_sheet.debt == "some updated debt"
      assert balance_sheet.equity == "some updated equity"
    end

    test "update_balance_sheet/2 with invalid data returns error changeset" do
      balance_sheet = balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_balance_sheet(balance_sheet, @invalid_attrs)
      assert balance_sheet == Reports.get_balance_sheet!(balance_sheet.id)
    end

    test "delete_balance_sheet/1 deletes the balance_sheet" do
      balance_sheet = balance_sheet_fixture()
      assert {:ok, %BalanceSheet{}} = Reports.delete_balance_sheet(balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_balance_sheet!(balance_sheet.id) end
    end

    test "change_balance_sheet/1 returns a balance_sheet changeset" do
      balance_sheet = balance_sheet_fixture()
      assert %Ecto.Changeset{} = Reports.change_balance_sheet(balance_sheet)
    end
  end

  describe "balance_sheets" do
    alias Demo.Reports.BalanceSheet

    @valid_attrs %{accounts_payable: "some accounts_payable", accounts_receivable: "some accounts_receivable", accrued_liabilities: "some accrued_liabilities", additional_paid_in_capital: "some additional_paid_in_capital", cash: "some cash", customer_prepayments: "some customer_prepayments", fixed_assets: "some fixed_assets", inventory: "some inventory", long_term_debt: "some long_term_debt", marketable_securities: "some marketable_securities", prepaid_expenses: "some prepaid_expenses", retained_earnings: "some retained_earnings", short_term_debt: "some short_term_debt", stock: "some stock", taxes: "some taxes", treasury_stock: "some treasury_stock"}
    @update_attrs %{accounts_payable: "some updated accounts_payable", accounts_receivable: "some updated accounts_receivable", accrued_liabilities: "some updated accrued_liabilities", additional_paid_in_capital: "some updated additional_paid_in_capital", cash: "some updated cash", customer_prepayments: "some updated customer_prepayments", fixed_assets: "some updated fixed_assets", inventory: "some updated inventory", long_term_debt: "some updated long_term_debt", marketable_securities: "some updated marketable_securities", prepaid_expenses: "some updated prepaid_expenses", retained_earnings: "some updated retained_earnings", short_term_debt: "some updated short_term_debt", stock: "some updated stock", taxes: "some updated taxes", treasury_stock: "some updated treasury_stock"}
    @invalid_attrs %{accounts_payable: nil, accounts_receivable: nil, accrued_liabilities: nil, additional_paid_in_capital: nil, cash: nil, customer_prepayments: nil, fixed_assets: nil, inventory: nil, long_term_debt: nil, marketable_securities: nil, prepaid_expenses: nil, retained_earnings: nil, short_term_debt: nil, stock: nil, taxes: nil, treasury_stock: nil}

    def balance_sheet_fixture(attrs \\ %{}) do
      {:ok, balance_sheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_balance_sheet()

      balance_sheet
    end

    test "list_balance_sheets/0 returns all balance_sheets" do
      balance_sheet = balance_sheet_fixture()
      assert Reports.list_balance_sheets() == [balance_sheet]
    end

    test "get_balance_sheet!/1 returns the balance_sheet with given id" do
      balance_sheet = balance_sheet_fixture()
      assert Reports.get_balance_sheet!(balance_sheet.id) == balance_sheet
    end

    test "create_balance_sheet/1 with valid data creates a balance_sheet" do
      assert {:ok, %BalanceSheet{} = balance_sheet} = Reports.create_balance_sheet(@valid_attrs)
      assert balance_sheet.accounts_payable == "some accounts_payable"
      assert balance_sheet.accounts_receivable == "some accounts_receivable"
      assert balance_sheet.accrued_liabilities == "some accrued_liabilities"
      assert balance_sheet.additional_paid_in_capital == "some additional_paid_in_capital"
      assert balance_sheet.cash == "some cash"
      assert balance_sheet.customer_prepayments == "some customer_prepayments"
      assert balance_sheet.fixed_assets == "some fixed_assets"
      assert balance_sheet.inventory == "some inventory"
      assert balance_sheet.long_term_debt == "some long_term_debt"
      assert balance_sheet.marketable_securities == "some marketable_securities"
      assert balance_sheet.prepaid_expenses == "some prepaid_expenses"
      assert balance_sheet.retained_earnings == "some retained_earnings"
      assert balance_sheet.short_term_debt == "some short_term_debt"
      assert balance_sheet.stock == "some stock"
      assert balance_sheet.taxes == "some taxes"
      assert balance_sheet.treasury_stock == "some treasury_stock"
    end

    test "create_balance_sheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_balance_sheet(@invalid_attrs)
    end

    test "update_balance_sheet/2 with valid data updates the balance_sheet" do
      balance_sheet = balance_sheet_fixture()
      assert {:ok, %BalanceSheet{} = balance_sheet} = Reports.update_balance_sheet(balance_sheet, @update_attrs)
      assert balance_sheet.accounts_payable == "some updated accounts_payable"
      assert balance_sheet.accounts_receivable == "some updated accounts_receivable"
      assert balance_sheet.accrued_liabilities == "some updated accrued_liabilities"
      assert balance_sheet.additional_paid_in_capital == "some updated additional_paid_in_capital"
      assert balance_sheet.cash == "some updated cash"
      assert balance_sheet.customer_prepayments == "some updated customer_prepayments"
      assert balance_sheet.fixed_assets == "some updated fixed_assets"
      assert balance_sheet.inventory == "some updated inventory"
      assert balance_sheet.long_term_debt == "some updated long_term_debt"
      assert balance_sheet.marketable_securities == "some updated marketable_securities"
      assert balance_sheet.prepaid_expenses == "some updated prepaid_expenses"
      assert balance_sheet.retained_earnings == "some updated retained_earnings"
      assert balance_sheet.short_term_debt == "some updated short_term_debt"
      assert balance_sheet.stock == "some updated stock"
      assert balance_sheet.taxes == "some updated taxes"
      assert balance_sheet.treasury_stock == "some updated treasury_stock"
    end

    test "update_balance_sheet/2 with invalid data returns error changeset" do
      balance_sheet = balance_sheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_balance_sheet(balance_sheet, @invalid_attrs)
      assert balance_sheet == Reports.get_balance_sheet!(balance_sheet.id)
    end

    test "delete_balance_sheet/1 deletes the balance_sheet" do
      balance_sheet = balance_sheet_fixture()
      assert {:ok, %BalanceSheet{}} = Reports.delete_balance_sheet(balance_sheet)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_balance_sheet!(balance_sheet.id) end
    end

    test "change_balance_sheet/1 returns a balance_sheet changeset" do
      balance_sheet = balance_sheet_fixture()
      assert %Ecto.Changeset{} = Reports.change_balance_sheet(balance_sheet)
    end
  end
end
