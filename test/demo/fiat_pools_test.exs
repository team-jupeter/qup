defmodule Demo.FiatPoolsTest do
  use Demo.DataCase

  alias Demo.FiatPools

  describe "fiat_pools" do
    alias Demo.FiatPools.FiatPool

    @valid_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
    @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
    @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

    def fiat_pool_fixture(attrs \\ %{}) do
      {:ok, fiat_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FiatPools.create_fiat_pool()

      fiat_pool
    end

    test "list_fiat_pools/0 returns all fiat_pools" do
      fiat_pool = fiat_pool_fixture()
      assert FiatPools.list_fiat_pools() == [fiat_pool]
    end

    test "get_fiat_pool!/1 returns the fiat_pool with given id" do
      fiat_pool = fiat_pool_fixture()
      assert FiatPools.get_fiat_pool!(fiat_pool.id) == fiat_pool
    end

    test "create_fiat_pool/1 with valid data creates a fiat_pool" do
      assert {:ok, %FiatPool{} = fiat_pool} = FiatPools.create_fiat_pool(@valid_attrs)
      assert fiat_pool.AUD == "some AUD"
      assert fiat_pool.CAD == "some CAD"
      assert fiat_pool.CHF == "some CHF"
      assert fiat_pool.CNY == "some CNY"
      assert fiat_pool.EUR == "some EUR"
      assert fiat_pool.GBP == "some GBP"
      assert fiat_pool.HKD == "some HKD"
      assert fiat_pool.JPY == "some JPY"
      assert fiat_pool.KRW == "some KRW"
      assert fiat_pool.MXN == "some MXN"
      assert fiat_pool.NOK == "some NOK"
      assert fiat_pool.NZD == "some NZD"
      assert fiat_pool.SEK == "some SEK"
      assert fiat_pool.SGD == "some SGD"
      assert fiat_pool.USD == "some USD"
    end

    test "create_fiat_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FiatPools.create_fiat_pool(@invalid_attrs)
    end

    test "update_fiat_pool/2 with valid data updates the fiat_pool" do
      fiat_pool = fiat_pool_fixture()
      assert {:ok, %FiatPool{} = fiat_pool} = FiatPools.update_fiat_pool(fiat_pool, @update_attrs)
      assert fiat_pool.AUD == "some updated AUD"
      assert fiat_pool.CAD == "some updated CAD"
      assert fiat_pool.CHF == "some updated CHF"
      assert fiat_pool.CNY == "some updated CNY"
      assert fiat_pool.EUR == "some updated EUR"
      assert fiat_pool.GBP == "some updated GBP"
      assert fiat_pool.HKD == "some updated HKD"
      assert fiat_pool.JPY == "some updated JPY"
      assert fiat_pool.KRW == "some updated KRW"
      assert fiat_pool.MXN == "some updated MXN"
      assert fiat_pool.NOK == "some updated NOK"
      assert fiat_pool.NZD == "some updated NZD"
      assert fiat_pool.SEK == "some updated SEK"
      assert fiat_pool.SGD == "some updated SGD"
      assert fiat_pool.USD == "some updated USD"
    end

    test "update_fiat_pool/2 with invalid data returns error changeset" do
      fiat_pool = fiat_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = FiatPools.update_fiat_pool(fiat_pool, @invalid_attrs)
      assert fiat_pool == FiatPools.get_fiat_pool!(fiat_pool.id)
    end

    test "delete_fiat_pool/1 deletes the fiat_pool" do
      fiat_pool = fiat_pool_fixture()
      assert {:ok, %FiatPool{}} = FiatPools.delete_fiat_pool(fiat_pool)
      assert_raise Ecto.NoResultsError, fn -> FiatPools.get_fiat_pool!(fiat_pool.id) end
    end

    test "change_fiat_pool/1 returns a fiat_pool changeset" do
      fiat_pool = fiat_pool_fixture()
      assert %Ecto.Changeset{} = FiatPools.change_fiat_pool(fiat_pool)
    end
  end
end
