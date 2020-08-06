defmodule Demo.T2ListsTest do
  use Demo.DataCase

  alias Demo.T2Lists

  describe "t2_lists" do
    alias Demo.T2Lists.T2List

    @valid_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
    @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
    @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

    def t2_list_fixture(attrs \\ %{}) do
      {:ok, t2_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T2Lists.create_t2_list()

      t2_list
    end

    test "list_t2_lists/0 returns all t2_lists" do
      t2_list = t2_list_fixture()
      assert T2Lists.list_t2_lists() == [t2_list]
    end

    test "get_t2_list!/1 returns the t2_list with given id" do
      t2_list = t2_list_fixture()
      assert T2Lists.get_t2_list!(t2_list.id) == t2_list
    end

    test "create_t2_list/1 with valid data creates a t2_list" do
      assert {:ok, %T2List{} = t2_list} = T2Lists.create_t2_list(@valid_attrs)
      assert t2_list.AUD == "some AUD"
      assert t2_list.CAD == "some CAD"
      assert t2_list.CHF == "some CHF"
      assert t2_list.CNY == "some CNY"
      assert t2_list.EUR == "some EUR"
      assert t2_list.GBP == "some GBP"
      assert t2_list.HKD == "some HKD"
      assert t2_list.JPY == "some JPY"
      assert t2_list.KRW == "some KRW"
      assert t2_list.MXN == "some MXN"
      assert t2_list.NOK == "some NOK"
      assert t2_list.NZD == "some NZD"
      assert t2_list.SEK == "some SEK"
      assert t2_list.SGD == "some SGD"
      assert t2_list.USD == "some USD"
    end

    test "create_t2_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T2Lists.create_t2_list(@invalid_attrs)
    end

    test "update_t2_list/2 with valid data updates the t2_list" do
      t2_list = t2_list_fixture()
      assert {:ok, %T2List{} = t2_list} = T2Lists.update_t2_list(t2_list, @update_attrs)
      assert t2_list.AUD == "some updated AUD"
      assert t2_list.CAD == "some updated CAD"
      assert t2_list.CHF == "some updated CHF"
      assert t2_list.CNY == "some updated CNY"
      assert t2_list.EUR == "some updated EUR"
      assert t2_list.GBP == "some updated GBP"
      assert t2_list.HKD == "some updated HKD"
      assert t2_list.JPY == "some updated JPY"
      assert t2_list.KRW == "some updated KRW"
      assert t2_list.MXN == "some updated MXN"
      assert t2_list.NOK == "some updated NOK"
      assert t2_list.NZD == "some updated NZD"
      assert t2_list.SEK == "some updated SEK"
      assert t2_list.SGD == "some updated SGD"
      assert t2_list.USD == "some updated USD"
    end

    test "update_t2_list/2 with invalid data returns error changeset" do
      t2_list = t2_list_fixture()
      assert {:error, %Ecto.Changeset{}} = T2Lists.update_t2_list(t2_list, @invalid_attrs)
      assert t2_list == T2Lists.get_t2_list!(t2_list.id)
    end

    test "delete_t2_list/1 deletes the t2_list" do
      t2_list = t2_list_fixture()
      assert {:ok, %T2List{}} = T2Lists.delete_t2_list(t2_list)
      assert_raise Ecto.NoResultsError, fn -> T2Lists.get_t2_list!(t2_list.id) end
    end

    test "change_t2_list/1 returns a t2_list changeset" do
      t2_list = t2_list_fixture()
      assert %Ecto.Changeset{} = T2Lists.change_t2_list(t2_list)
    end
  end
end
