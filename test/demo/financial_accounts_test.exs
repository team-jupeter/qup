defmodule Demo.FinancialAccountsTest do
  use Demo.DataCase

  alias Demo.FinancialAccounts

  describe "financial_accounts" do
    alias Demo.FinancialAccounts.FinancialAccount

    @valid_attrs %{account: "some account", left: "some left", right: "some right"}
    @update_attrs %{account: "some updated account", left: "some updated left", right: "some updated right"}
    @invalid_attrs %{account: nil, left: nil, right: nil}

    def financial_account_fixture(attrs \\ %{}) do
      {:ok, financial_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FinancialAccounts.create_financial_account()

      financial_account
    end

    test "list_financial_accounts/0 returns all financial_accounts" do
      financial_account = financial_account_fixture()
      assert FinancialAccounts.list_financial_accounts() == [financial_account]
    end

    test "get_financial_account!/1 returns the financial_account with given id" do
      financial_account = financial_account_fixture()
      assert FinancialAccounts.get_financial_account!(financial_account.id) == financial_account
    end

    test "create_financial_account/1 with valid data creates a financial_account" do
      assert {:ok, %FinancialAccount{} = financial_account} = FinancialAccounts.create_financial_account(@valid_attrs)
      assert financial_account.account == "some account"
      assert financial_account.left == "some left"
      assert financial_account.right == "some right"
    end

    test "create_financial_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FinancialAccounts.create_financial_account(@invalid_attrs)
    end

    test "update_financial_account/2 with valid data updates the financial_account" do
      financial_account = financial_account_fixture()
      assert {:ok, %FinancialAccount{} = financial_account} = FinancialAccounts.update_financial_account(financial_account, @update_attrs)
      assert financial_account.account == "some updated account"
      assert financial_account.left == "some updated left"
      assert financial_account.right == "some updated right"
    end

    test "update_financial_account/2 with invalid data returns error changeset" do
      financial_account = financial_account_fixture()
      assert {:error, %Ecto.Changeset{}} = FinancialAccounts.update_financial_account(financial_account, @invalid_attrs)
      assert financial_account == FinancialAccounts.get_financial_account!(financial_account.id)
    end

    test "delete_financial_account/1 deletes the financial_account" do
      financial_account = financial_account_fixture()
      assert {:ok, %FinancialAccount{}} = FinancialAccounts.delete_financial_account(financial_account)
      assert_raise Ecto.NoResultsError, fn -> FinancialAccounts.get_financial_account!(financial_account.id) end
    end

    test "change_financial_account/1 returns a financial_account changeset" do
      financial_account = financial_account_fixture()
      assert %Ecto.Changeset{} = FinancialAccounts.change_financial_account(financial_account)
    end
  end
end
