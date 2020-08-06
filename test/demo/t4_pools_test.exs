defmodule Demo.T4ListsTest do
  use Demo.DataCase

  alias Demo.T4Lists

  describe "t4_lists" do
    alias Demo.T4Lists.T4List

    @valid_attrs %{BSE: "some BSE", DB: "some DB", ENX: "some ENX", JPX: "some JPX", KRX: "some KRX", LSE: "some LSE", NASDAQ: "some NASDAQ", NSE: "some NSE", NYSE: "some NYSE", SEHK: "some SEHK", SIX: "some SIX", SSE: "some SSE", SZSE: "some SZSE", TSX: "some TSX"}
    @update_attrs %{BSE: "some updated BSE", DB: "some updated DB", ENX: "some updated ENX", JPX: "some updated JPX", KRX: "some updated KRX", LSE: "some updated LSE", NASDAQ: "some updated NASDAQ", NSE: "some updated NSE", NYSE: "some updated NYSE", SEHK: "some updated SEHK", SIX: "some updated SIX", SSE: "some updated SSE", SZSE: "some updated SZSE", TSX: "some updated TSX"}
    @invalid_attrs %{BSE: nil, DB: nil, ENX: nil, JPX: nil, KRX: nil, LSE: nil, NASDAQ: nil, NSE: nil, NYSE: nil, SEHK: nil, SIX: nil, SSE: nil, SZSE: nil, TSX: nil}

    def t4_list_fixture(attrs \\ %{}) do
      {:ok, t4_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T4Lists.create_t4_list()

      t4_list
    end

    test "list_t4_lists/0 returns all t4_lists" do
      t4_list = t4_list_fixture()
      assert T4Lists.list_t4_lists() == [t4_list]
    end

    test "get_t4_list!/1 returns the t4_list with given id" do
      t4_list = t4_list_fixture()
      assert T4Lists.get_t4_list!(t4_list.id) == t4_list
    end

    test "create_t4_list/1 with valid data creates a t4_list" do
      assert {:ok, %T4List{} = t4_list} = T4Lists.create_t4_list(@valid_attrs)
      assert t4_list.BSE == "some BSE"
      assert t4_list.DB == "some DB"
      assert t4_list.ENX == "some ENX"
      assert t4_list.JPX == "some JPX"
      assert t4_list.KRX == "some KRX"
      assert t4_list.LSE == "some LSE"
      assert t4_list.NASDAQ == "some NASDAQ"
      assert t4_list.NSE == "some NSE"
      assert t4_list.NYSE == "some NYSE"
      assert t4_list.SEHK == "some SEHK"
      assert t4_list.SIX == "some SIX"
      assert t4_list.SSE == "some SSE"
      assert t4_list.SZSE == "some SZSE"
      assert t4_list.TSX == "some TSX"
    end

    test "create_t4_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T4Lists.create_t4_list(@invalid_attrs)
    end

    test "update_t4_list/2 with valid data updates the t4_list" do
      t4_list = t4_list_fixture()
      assert {:ok, %T4List{} = t4_list} = T4Lists.update_t4_list(t4_list, @update_attrs)
      assert t4_list.BSE == "some updated BSE"
      assert t4_list.DB == "some updated DB"
      assert t4_list.ENX == "some updated ENX"
      assert t4_list.JPX == "some updated JPX"
      assert t4_list.KRX == "some updated KRX"
      assert t4_list.LSE == "some updated LSE"
      assert t4_list.NASDAQ == "some updated NASDAQ"
      assert t4_list.NSE == "some updated NSE"
      assert t4_list.NYSE == "some updated NYSE"
      assert t4_list.SEHK == "some updated SEHK"
      assert t4_list.SIX == "some updated SIX"
      assert t4_list.SSE == "some updated SSE"
      assert t4_list.SZSE == "some updated SZSE"
      assert t4_list.TSX == "some updated TSX"
    end

    test "update_t4_list/2 with invalid data returns error changeset" do
      t4_list = t4_list_fixture()
      assert {:error, %Ecto.Changeset{}} = T4Lists.update_t4_list(t4_list, @invalid_attrs)
      assert t4_list == T4Lists.get_t4_list!(t4_list.id)
    end

    test "delete_t4_list/1 deletes the t4_list" do
      t4_list = t4_list_fixture()
      assert {:ok, %T4List{}} = T4Lists.delete_t4_list(t4_list)
      assert_raise Ecto.NoResultsError, fn -> T4Lists.get_t4_list!(t4_list.id) end
    end

    test "change_t4_list/1 returns a t4_list changeset" do
      t4_list = t4_list_fixture()
      assert %Ecto.Changeset{} = T4Lists.change_t4_list(t4_list)
    end
  end
end
