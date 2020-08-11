defmodule Demo.T3sTest do
  use Demo.DataCase

  alias Demo.T3s

  describe "t3s" do
    alias Demo.T3s.T3

    @valid_attrs %{num_of_stocks: "some num_of_stocks", price_per_share: "some price_per_share"}
    @update_attrs %{num_of_stocks: "some updated num_of_stocks", price_per_share: "some updated price_per_share"}
    @invalid_attrs %{num_of_stocks: nil, price_per_share: nil}

    def t3_fixture(attrs \\ %{}) do
      {:ok, t3} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T3s.create_t3()

      t3
    end

    test "list_t3s/0 returns all t3s" do
      t3 = t3_fixture()
      assert T3s.list_t3s() == [t3]
    end

    test "get_t3!/1 returns the t3 with given id" do
      t3 = t3_fixture()
      assert T3s.get_t3!(t3.id) == t3
    end

    test "create_t3/1 with valid data creates a t3" do
      assert {:ok, %T3{} = t3} = T3s.create_t3(@valid_attrs)
      assert t3.num_of_stocks == "some num_of_stocks"
      assert t3.price_per_share == "some price_per_share"
    end

    test "create_t3/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T3s.create_t3(@invalid_attrs)
    end

    test "update_t3/2 with valid data updates the t3" do
      t3 = t3_fixture()
      assert {:ok, %T3{} = t3} = T3s.update_t3(t3, @update_attrs)
      assert t3.num_of_stocks == "some updated num_of_stocks"
      assert t3.price_per_share == "some updated price_per_share"
    end

    test "update_t3/2 with invalid data returns error changeset" do
      t3 = t3_fixture()
      assert {:error, %Ecto.Changeset{}} = T3s.update_t3(t3, @invalid_attrs)
      assert t3 == T3s.get_t3!(t3.id)
    end

    test "delete_t3/1 deletes the t3" do
      t3 = t3_fixture()
      assert {:ok, %T3{}} = T3s.delete_t3(t3)
      assert_raise Ecto.NoResultsError, fn -> T3s.get_t3!(t3.id) end
    end

    test "change_t3/1 returns a t3 changeset" do
      t3 = t3_fixture()
      assert %Ecto.Changeset{} = T3s.change_t3(t3)
    end
  end

  describe "t3_pools" do
    alias Demo.T3Pools.T3Pool

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def t3_pool_fixture(attrs \\ %{}) do
      {:ok, t3_pool} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T3Pools.create_t3_pool()

      t3_pool
    end

    test "list_t3_pools/0 returns all t3_pools" do
      t3_pool = t3_pool_fixture()
      assert T3Pools.list_t3_pools() == [t3_pool]
    end

    test "get_t3_pool!/1 returns the t3_pool with given id" do
      t3_pool = t3_pool_fixture()
      assert T3Pools.get_t3_pool!(t3_pool.id) == t3_pool
    end

    test "create_t3_pool/1 with valid data creates a t3_pool" do
      assert {:ok, %T3Pool{} = t3_pool} = T3Pools.create_t3_pool(@valid_attrs)
    end

    test "create_t3_pool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T3Pools.create_t3_pool(@invalid_attrs)
    end

    test "update_t3_pool/2 with valid data updates the t3_pool" do
      t3_pool = t3_pool_fixture()
      assert {:ok, %T3Pool{} = t3_pool} = T3Pools.update_t3_pool(t3_pool, @update_attrs)
    end

    test "update_t3_pool/2 with invalid data returns error changeset" do
      t3_pool = t3_pool_fixture()
      assert {:error, %Ecto.Changeset{}} = T3Pools.update_t3_pool(t3_pool, @invalid_attrs)
      assert t3_pool == T3Pools.get_t3_pool!(t3_pool.id)
    end

    test "delete_t3_pool/1 deletes the t3_pool" do
      t3_pool = t3_pool_fixture()
      assert {:ok, %T3Pool{}} = T3Pools.delete_t3_pool(t3_pool)
      assert_raise Ecto.NoResultsError, fn -> T3Pools.get_t3_pool!(t3_pool.id) end
    end

    test "change_t3_pool/1 returns a t3_pool changeset" do
      t3_pool = t3_pool_fixture()
      assert %Ecto.Changeset{} = T3Pools.change_t3_pool(t3_pool)
    end
  end
end
