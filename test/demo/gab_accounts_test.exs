defmodule Demo.GabAccountsTest do
  use Demo.DataCase

  alias Demo.GabAccounts

  describe "gab_accounts" do
    alias Demo.GabAccounts.GabAccount

    @valid_attrs %{t1a: "120.5", t1b: "120.5", t2: "120.5", t3: "120.5"}
    @update_attrs %{t1a: "456.7", t1b: "456.7", t2: "456.7", t3: "456.7"}
    @invalid_attrs %{t1a: nil, t1b: nil, t2: nil, t3: nil}

    def gab_account_fixture(attrs \\ %{}) do
      {:ok, gab_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GabAccounts.create_gab_account()

      gab_account
    end

    test "list_gab_accounts/0 returns all gab_accounts" do
      gab_account = gab_account_fixture()
      assert GabAccounts.list_gab_accounts() == [gab_account]
    end

    test "get_gab_account!/1 returns the gab_account with given id" do
      gab_account = gab_account_fixture()
      assert GabAccounts.get_gab_account!(gab_account.id) == gab_account
    end

    test "create_gab_account/1 with valid data creates a gab_account" do
      assert {:ok, %GabAccount{} = gab_account} = GabAccounts.create_gab_account(@valid_attrs)
      assert gab_account.t1a == Decimal.new("120.5")
      assert gab_account.t1b == Decimal.new("120.5")
      assert gab_account.t2 == Decimal.new("120.5")
      assert gab_account.t3 == Decimal.new("120.5")
    end

    test "create_gab_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GabAccounts.create_gab_account(@invalid_attrs)
    end

    test "update_gab_account/2 with valid data updates the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GabAccount{} = gab_account} = GabAccounts.update_gab_account(gab_account, @update_attrs)
      assert gab_account.t1a == Decimal.new("456.7")
      assert gab_account.t1b == Decimal.new("456.7")
      assert gab_account.t2 == Decimal.new("456.7")
      assert gab_account.t3 == Decimal.new("456.7")
    end

    test "update_gab_account/2 with invalid data returns error changeset" do
      gab_account = gab_account_fixture()
      assert {:error, %Ecto.Changeset{}} = GabAccounts.update_gab_account(gab_account, @invalid_attrs)
      assert gab_account == GabAccounts.get_gab_account!(gab_account.id)
    end

    test "delete_gab_account/1 deletes the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GabAccount{}} = GabAccounts.delete_gab_account(gab_account)
      assert_raise Ecto.NoResultsError, fn -> GabAccounts.get_gab_account!(gab_account.id) end
    end

    test "change_gab_account/1 returns a gab_account changeset" do
      gab_account = gab_account_fixture()
      assert %Ecto.Changeset{} = GabAccounts.change_gab_account(gab_account)
    end
  end

  describe "gab_accounts" do
    alias Demo.GabAccounts.GabAccount

    @valid_attrs %{balance: "120.5"}
    @update_attrs %{balance: "456.7"}
    @invalid_attrs %{balance: nil}

    def gab_account_fixture(attrs \\ %{}) do
      {:ok, gab_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GabAccounts.create_gab_account()

      gab_account
    end

    test "list_gab_accounts/0 returns all gab_accounts" do
      gab_account = gab_account_fixture()
      assert GabAccounts.list_gab_accounts() == [gab_account]
    end

    test "get_gab_account!/1 returns the gab_account with given id" do
      gab_account = gab_account_fixture()
      assert GabAccounts.get_gab_account!(gab_account.id) == gab_account
    end

    test "create_gab_account/1 with valid data creates a gab_account" do
      assert {:ok, %GabAccount{} = gab_account} = GabAccounts.create_gab_account(@valid_attrs)
      assert gab_account.balance == Decimal.new("120.5")
    end

    test "create_gab_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GabAccounts.create_gab_account(@invalid_attrs)
    end

    test "update_gab_account/2 with valid data updates the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GabAccount{} = gab_account} = GabAccounts.update_gab_account(gab_account, @update_attrs)
      assert gab_account.balance == Decimal.new("456.7")
    end

    test "update_gab_account/2 with invalid data returns error changeset" do
      gab_account = gab_account_fixture()
      assert {:error, %Ecto.Changeset{}} = GabAccounts.update_gab_account(gab_account, @invalid_attrs)
      assert gab_account == GabAccounts.get_gab_account!(gab_account.id)
    end

    test "delete_gab_account/1 deletes the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GabAccount{}} = GabAccounts.delete_gab_account(gab_account)
      assert_raise Ecto.NoResultsError, fn -> GabAccounts.get_gab_account!(gab_account.id) end
    end

    test "change_gab_account/1 returns a gab_account changeset" do
      gab_account = gab_account_fixture()
      assert %Ecto.Changeset{} = GabAccounts.change_gab_account(gab_account)
    end
  end

  describe "gab_accounts" do
    alias Demo.GabAccounts.GabAccount

    @valid_attrs %{credit_limit: "some credit_limit", owner: "some owner", t1: "some t1", t2: "some t2", t3: "some t3"}
    @update_attrs %{credit_limit: "some updated credit_limit", owner: "some updated owner", t1: "some updated t1", t2: "some updated t2", t3: "some updated t3"}
    @invalid_attrs %{credit_limit: nil, owner: nil, t1: nil, t2: nil, t3: nil}

    def gab_account_fixture(attrs \\ %{}) do
      {:ok, gab_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GabAccounts.create_gab_account()

      gab_account
    end

    test "list_gab_accounts/0 returns all gab_accounts" do
      gab_account = gab_account_fixture()
      assert GabAccounts.list_gab_accounts() == [gab_account]
    end

    test "get_gab_account!/1 returns the gab_account with given id" do
      gab_account = gab_account_fixture()
      assert GabAccounts.get_gab_account!(gab_account.id) == gab_account
    end

    test "create_gab_account/1 with valid data creates a gab_account" do
      assert {:ok, %GabAccount{} = gab_account} = GabAccounts.create_gab_account(@valid_attrs)
      assert gab_account.credit_limit == "some credit_limit"
      assert gab_account.owner == "some owner"
      assert gab_account.t1 == "some t1"
      assert gab_account.t2 == "some t2"
      assert gab_account.t3 == "some t3"
    end

    test "create_gab_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GabAccounts.create_gab_account(@invalid_attrs)
    end

    test "update_gab_account/2 with valid data updates the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GabAccount{} = gab_account} = GabAccounts.update_gab_account(gab_account, @update_attrs)
      assert gab_account.credit_limit == "some updated credit_limit"
      assert gab_account.owner == "some updated owner"
      assert gab_account.t1 == "some updated t1"
      assert gab_account.t2 == "some updated t2"
      assert gab_account.t3 == "some updated t3"
    end

    test "update_gab_account/2 with invalid data returns error changeset" do
      gab_account = gab_account_fixture()
      assert {:error, %Ecto.Changeset{}} = GabAccounts.update_gab_account(gab_account, @invalid_attrs)
      assert gab_account == GabAccounts.get_gab_account!(gab_account.id)
    end

    test "delete_gab_account/1 deletes the gab_account" do
      gab_account = gab_account_fixture()
      assert {:ok, %GabAccount{}} = GabAccounts.delete_gab_account(gab_account)
      assert_raise Ecto.NoResultsError, fn -> GabAccounts.get_gab_account!(gab_account.id) end
    end

    test "change_gab_account/1 returns a gab_account changeset" do
      gab_account = gab_account_fixture()
      assert %Ecto.Changeset{} = GabAccounts.change_gab_account(gab_account)
    end
  end
end
