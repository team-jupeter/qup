defmodule Demo.T1ListsTest do
  use Demo.DataCase

  alias Demo.T1Lists

  describe "t1_lists" do
    alias Demo.T1Lists.T1List

    @valid_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
    @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
    @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

    def t1_list_fixture(attrs \\ %{}) do
      {:ok, t1_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T1Lists.create_t1_list()

      t1_list
    end

    test "list_t1_lists/0 returns all t1_lists" do
      t1_list = t1_list_fixture()
      assert T1Lists.list_t1_lists() == [t1_list]
    end

    test "get_t1_list!/1 returns the t1_list with given id" do
      t1_list = t1_list_fixture()
      assert T1Lists.get_t1_list!(t1_list.id) == t1_list
    end

    test "create_t1_list/1 with valid data creates a t1_list" do
      assert {:ok, %T1List{} = t1_list} = T1Lists.create_t1_list(@valid_attrs)
      assert t1_list.AUD == "some AUD"
      assert t1_list.CAD == "some CAD"
      assert t1_list.CHF == "some CHF"
      assert t1_list.CNY == "some CNY"
      assert t1_list.EUR == "some EUR"
      assert t1_list.GBP == "some GBP"
      assert t1_list.HKD == "some HKD"
      assert t1_list.JPY == "some JPY"
      assert t1_list.KRW == "some KRW"
      assert t1_list.MXN == "some MXN"
      assert t1_list.NOK == "some NOK"
      assert t1_list.NZD == "some NZD"
      assert t1_list.SEK == "some SEK"
      assert t1_list.SGD == "some SGD"
      assert t1_list.USD == "some USD"
    end

    test "create_t1_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T1Lists.create_t1_list(@invalid_attrs)
    end

    test "update_t1_list/2 with valid data updates the t1_list" do
      t1_list = t1_list_fixture()
      assert {:ok, %T1List{} = t1_list} = T1Lists.update_t1_list(t1_list, @update_attrs)
      assert t1_list.AUD == "some updated AUD"
      assert t1_list.CAD == "some updated CAD"
      assert t1_list.CHF == "some updated CHF"
      assert t1_list.CNY == "some updated CNY"
      assert t1_list.EUR == "some updated EUR"
      assert t1_list.GBP == "some updated GBP"
      assert t1_list.HKD == "some updated HKD"
      assert t1_list.JPY == "some updated JPY"
      assert t1_list.KRW == "some updated KRW"
      assert t1_list.MXN == "some updated MXN"
      assert t1_list.NOK == "some updated NOK"
      assert t1_list.NZD == "some updated NZD"
      assert t1_list.SEK == "some updated SEK"
      assert t1_list.SGD == "some updated SGD"
      assert t1_list.USD == "some updated USD"
    end

    test "update_t1_list/2 with invalid data returns error changeset" do
      t1_list = t1_list_fixture()
      assert {:error, %Ecto.Changeset{}} = T1Lists.update_t1_list(t1_list, @invalid_attrs)
      assert t1_list == T1Lists.get_t1_list!(t1_list.id)
    end

    test "delete_t1_list/1 deletes the t1_list" do
      t1_list = t1_list_fixture()
      assert {:ok, %T1List{}} = T1Lists.delete_t1_list(t1_list)
      assert_raise Ecto.NoResultsError, fn -> T1Lists.get_t1_list!(t1_list.id) end
    end

    test "change_t1_list/1 returns a t1_list changeset" do
      t1_list = t1_list_fixture()
      assert %Ecto.Changeset{} = T1Lists.change_t1_list(t1_list)
    end
  end
end
