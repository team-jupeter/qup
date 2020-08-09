defmodule Demo.T1sTest do
  use Demo.DataCase

  alias Demo.T1s

  describe "t1s" do
    alias Demo.T1s.T1

    @valid_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
    @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
    @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

    def t1_fixture(attrs \\ %{}) do
      {:ok, t1} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T1s.create_t1()

      t1
    end

    test "list_t1s/0 returns all t1s" do
      t1 = t1_fixture()
      assert T1s.list_t1s() == [t1]
    end

    test "get_t1!/1 returns the t1 with given id" do
      t1 = t1_fixture()
      assert T1s.get_t1!(t1.id) == t1
    end

    test "create_t1/1 with valid data creates a t1" do
      assert {:ok, %T1{} = t1} = T1s.create_t1(@valid_attrs)
      assert t1.AUD == "some AUD"
      assert t1.CAD == "some CAD"
      assert t1.CHF == "some CHF"
      assert t1.CNY == "some CNY"
      assert t1.EUR == "some EUR"
      assert t1.GBP == "some GBP"
      assert t1.HKD == "some HKD"
      assert t1.JPY == "some JPY"
      assert t1.KRW == "some KRW"
      assert t1.MXN == "some MXN"
      assert t1.NOK == "some NOK"
      assert t1.NZD == "some NZD"
      assert t1.SEK == "some SEK"
      assert t1.SGD == "some SGD"
      assert t1.USD == "some USD"
    end

    test "create_t1/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T1s.create_t1(@invalid_attrs)
    end

    test "update_t1/2 with valid data updates the t1" do
      t1 = t1_fixture()
      assert {:ok, %T1{} = t1} = T1s.update_t1(t1, @update_attrs)
      assert t1.AUD == "some updated AUD"
      assert t1.CAD == "some updated CAD"
      assert t1.CHF == "some updated CHF"
      assert t1.CNY == "some updated CNY"
      assert t1.EUR == "some updated EUR"
      assert t1.GBP == "some updated GBP"
      assert t1.HKD == "some updated HKD"
      assert t1.JPY == "some updated JPY"
      assert t1.KRW == "some updated KRW"
      assert t1.MXN == "some updated MXN"
      assert t1.NOK == "some updated NOK"
      assert t1.NZD == "some updated NZD"
      assert t1.SEK == "some updated SEK"
      assert t1.SGD == "some updated SGD"
      assert t1.USD == "some updated USD"
    end

    test "update_t1/2 with invalid data returns error changeset" do
      t1 = t1_fixture()
      assert {:error, %Ecto.Changeset{}} = T1s.update_t1(t1, @invalid_attrs)
      assert t1 == T1s.get_t1!(t1.id)
    end

    test "delete_t1/1 deletes the t1" do
      t1 = t1_fixture()
      assert {:ok, %T1{}} = T1s.delete_t1(t1)
      assert_raise Ecto.NoResultsError, fn -> T1s.get_t1!(t1.id) end
    end

    test "change_t1/1 returns a t1 changeset" do
      t1 = t1_fixture()
      assert %Ecto.Changeset{} = T1s.change_t1(t1)
    end
  end
end
