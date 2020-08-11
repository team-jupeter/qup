defmodule Demo.T4sTest do
  use Demo.DataCase

  alias Demo.T4s

  describe "t4s" do
    alias Demo.T4s.T4

    @valid_attrs %{BSE: "some BSE", DB: "some DB", ENX: "some ENX", JPX: "some JPX", KRX: "some KRX", LSE: "some LSE", NASDAQ: "some NASDAQ", NSE: "some NSE", NYSE: "some NYSE", SEHK: "some SEHK", SIX: "some SIX", SSE: "some SSE", SZSE: "some SZSE", TSX: "some TSX"}
    @update_attrs %{BSE: "some updated BSE", DB: "some updated DB", ENX: "some updated ENX", JPX: "some updated JPX", KRX: "some updated KRX", LSE: "some updated LSE", NASDAQ: "some updated NASDAQ", NSE: "some updated NSE", NYSE: "some updated NYSE", SEHK: "some updated SEHK", SIX: "some updated SIX", SSE: "some updated SSE", SZSE: "some updated SZSE", TSX: "some updated TSX"}
    @invalid_attrs %{BSE: nil, DB: nil, ENX: nil, JPX: nil, KRX: nil, LSE: nil, NASDAQ: nil, NSE: nil, NYSE: nil, SEHK: nil, SIX: nil, SSE: nil, SZSE: nil, TSX: nil}

    def t4_fixture(attrs \\ %{}) do
      {:ok, t4} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T4s.create_t4()

      t4
    end

    test "list_t4s/0 returns all t4s" do
      t4 = t4_fixture()
      assert T4s.list_t4s() == [t4]
    end

    test "get_t4!/1 returns the t4 with given id" do
      t4 = t4_fixture()
      assert T4s.get_t4!(t4.id) == t4
    end

    test "create_t4/1 with valid data creates a t4" do
      assert {:ok, %T4{} = t4} = T4s.create_t4(@valid_attrs)
      assert t4.BSE == "some BSE"
      assert t4.DB == "some DB"
      assert t4.ENX == "some ENX"
      assert t4.JPX == "some JPX"
      assert t4.KRX == "some KRX"
      assert t4.LSE == "some LSE"
      assert t4.NASDAQ == "some NASDAQ"
      assert t4.NSE == "some NSE"
      assert t4.NYSE == "some NYSE"
      assert t4.SEHK == "some SEHK"
      assert t4.SIX == "some SIX"
      assert t4.SSE == "some SSE"
      assert t4.SZSE == "some SZSE"
      assert t4.TSX == "some TSX"
    end

    test "create_t4/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T4s.create_t4(@invalid_attrs)
    end

    test "update_t4/2 with valid data updates the t4" do
      t4 = t4_fixture()
      assert {:ok, %T4{} = t4} = T4s.update_t4(t4, @update_attrs)
      assert t4.BSE == "some updated BSE"
      assert t4.DB == "some updated DB"
      assert t4.ENX == "some updated ENX"
      assert t4.JPX == "some updated JPX"
      assert t4.KRX == "some updated KRX"
      assert t4.LSE == "some updated LSE"
      assert t4.NASDAQ == "some updated NASDAQ"
      assert t4.NSE == "some updated NSE"
      assert t4.NYSE == "some updated NYSE"
      assert t4.SEHK == "some updated SEHK"
      assert t4.SIX == "some updated SIX"
      assert t4.SSE == "some updated SSE"
      assert t4.SZSE == "some updated SZSE"
      assert t4.TSX == "some updated TSX"
    end

    test "update_t4/2 with invalid data returns error changeset" do
      t4 = t4_fixture()
      assert {:error, %Ecto.Changeset{}} = T4s.update_t4(t4, @invalid_attrs)
      assert t4 == T4s.get_t4!(t4.id)
    end

    test "delete_t4/1 deletes the t4" do
      t4 = t4_fixture()
      assert {:ok, %T4{}} = T4s.delete_t4(t4)
      assert_raise Ecto.NoResultsError, fn -> T4s.get_t4!(t4.id) end
    end

    test "change_t4/1 returns a t4 changeset" do
      t4 = t4_fixture()
      assert %Ecto.Changeset{} = T4s.change_t4(t4)
    end
  end

  describe "t4_pools" do
    alias Demo.T4Pools.T4Pool

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def t4_pool_fixture(attrs \\ %{}) do
      {:ok, t4_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T4Pools.create_t4_pool()

      t4_pool
    end

    test "list_t4_pools/0 returns all t4_pools" do
      t4_pool = t4_pool_fixture()
      assert T4Pools.list_t4_pools() == [t4_pool]
    end

    test "get_t4_pool!/1 returns the t4_pool with given id" do
      t4_pool = t4_pool_fixture()
      assert T4Pools.get_t4_pool!(t4_pool.id) == t4_pool
    end

    test "create_t4_pool/1 with valid data creates a t4_pool" do
      assert {:ok, %T4Pool{} = t4_pool} = T4Pools.create_t4_pool(@valid_attrs)
    end

    test "create_t4_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T4Pools.create_t4_pool(@invalid_attrs)
    end

    test "update_t4_pool/2 with valid data updates the t4_pool" do
      t4_pool = t4_pool_fixture()
      assert {:ok, %T4Pool{} = t4_pool} = T4Pools.update_t4_pool(t4_pool, @update_attrs)
    end

    test "update_t4_pool/2 with invalid data returns error changeset" do
      t4_pool = t4_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T4Pools.update_t4_pool(t4_pool, @invalid_attrs)
      assert t4_pool == T4Pools.get_t4_pool!(t4_pool.id)
    end

    test "delete_t4_pool/1 deletes the t4_pool" do
      t4_pool = t4_pool_fixture()
      assert {:ok, %T4Pool{}} = T4Pools.delete_t4_pool(t4_pool)
      assert_raise Ecto.NoResultsError, fn -> T4Pools.get_t4_pool!(t4_pool.id) end
    end

    test "change_t4_pool/1 returns a t4_pool changeset" do
      t4_pool = t4_pool_fixture()
      assert %Ecto.Changeset{} = T4Pools.change_t4_pool(t4_pool)
    end
  end
end
