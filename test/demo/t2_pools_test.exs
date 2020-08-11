defmodule Demo.T2sTest do
  use Demo.DataCase

  alias Demo.T2s

  describe "t2s" do
    alias Demo.T2s.T2

    @valid_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
    @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
    @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

    def t2_fixture(attrs \\ %{}) do
      {:ok, t2} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T2s.create_t2()

      t2
    end

    test "list_t2s/0 returns all t2s" do
      t2 = t2_fixture()
      assert T2s.list_t2s() == [t2]
    end

    test "get_t2!/1 returns the t2 with given id" do
      t2 = t2_fixture()
      assert T2s.get_t2!(t2.id) == t2
    end

    test "create_t2/1 with valid data creates a t2" do
      assert {:ok, %T2{} = t2} = T2s.create_t2(@valid_attrs)
      assert t2.AUD == "some AUD"
      assert t2.CAD == "some CAD"
      assert t2.CHF == "some CHF"
      assert t2.CNY == "some CNY"
      assert t2.EUR == "some EUR"
      assert t2.GBP == "some GBP"
      assert t2.HKD == "some HKD"
      assert t2.JPY == "some JPY"
      assert t2.KRW == "some KRW"
      assert t2.MXN == "some MXN"
      assert t2.NOK == "some NOK"
      assert t2.NZD == "some NZD"
      assert t2.SEK == "some SEK"
      assert t2.SGD == "some SGD"
      assert t2.USD == "some USD"
    end

    test "create_t2/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T2s.create_t2(@invalid_attrs)
    end

    test "update_t2/2 with valid data updates the t2" do
      t2 = t2_fixture()
      assert {:ok, %T2{} = t2} = T2s.update_t2(t2, @update_attrs)
      assert t2.AUD == "some updated AUD"
      assert t2.CAD == "some updated CAD"
      assert t2.CHF == "some updated CHF"
      assert t2.CNY == "some updated CNY"
      assert t2.EUR == "some updated EUR"
      assert t2.GBP == "some updated GBP"
      assert t2.HKD == "some updated HKD"
      assert t2.JPY == "some updated JPY"
      assert t2.KRW == "some updated KRW"
      assert t2.MXN == "some updated MXN"
      assert t2.NOK == "some updated NOK"
      assert t2.NZD == "some updated NZD"
      assert t2.SEK == "some updated SEK"
      assert t2.SGD == "some updated SGD"
      assert t2.USD == "some updated USD"
    end

    test "update_t2/2 with invalid data returns error changeset" do
      t2 = t2_fixture()
      assert {:error, %Ecto.Changeset{}} = T2s.update_t2(t2, @invalid_attrs)
      assert t2 == T2s.get_t2!(t2.id)
    end

    test "delete_t2/1 deletes the t2" do
      t2 = t2_fixture()
      assert {:ok, %T2{}} = T2s.delete_t2(t2)
      assert_raise Ecto.NoResultsError, fn -> T2s.get_t2!(t2.id) end
    end

    test "change_t2/1 returns a t2 changeset" do
      t2 = t2_fixture()
      assert %Ecto.Changeset{} = T2s.change_t2(t2)
    end
  end

  describe "t2_pools" do
    alias Demo.T2Pools.T2Pool

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def t2_pool_fixture(attrs \\ %{}) do
      {:ok, t2_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T2Pools.create_t2_pool()

      t2_pool
    end

    test "list_t2_pools/0 returns all t2_pools" do
      t2_pool = t2_pool_fixture()
      assert T2Pools.list_t2_pools() == [t2_pool]
    end

    test "get_t2_pool!/1 returns the t2_pool with given id" do
      t2_pool = t2_pool_fixture()
      assert T2Pools.get_t2_pool!(t2_pool.id) == t2_pool
    end

    test "create_t2_pool/1 with valid data creates a t2_pool" do
      assert {:ok, %T2Pool{} = t2_pool} = T2Pools.create_t2_pool(@valid_attrs)
    end

    test "create_t2_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T2Pools.create_t2_pool(@invalid_attrs)
    end

    test "update_t2_pool/2 with valid data updates the t2_pool" do
      t2_pool = t2_pool_fixture()
      assert {:ok, %T2Pool{} = t2_pool} = T2Pools.update_t2_pool(t2_pool, @update_attrs)
    end

    test "update_t2_pool/2 with invalid data returns error changeset" do
      t2_pool = t2_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T2Pools.update_t2_pool(t2_pool, @invalid_attrs)
      assert t2_pool == T2Pools.get_t2_pool!(t2_pool.id)
    end

    test "delete_t2_pool/1 deletes the t2_pool" do
      t2_pool = t2_pool_fixture()
      assert {:ok, %T2Pool{}} = T2Pools.delete_t2_pool(t2_pool)
      assert_raise Ecto.NoResultsError, fn -> T2Pools.get_t2_pool!(t2_pool.id) end
    end

    test "change_t2_pool/1 returns a t2_pool changeset" do
      t2_pool = t2_pool_fixture()
      assert %Ecto.Changeset{} = T2Pools.change_t2_pool(t2_pool)
    end
  end
end
