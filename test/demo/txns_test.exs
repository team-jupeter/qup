defmodule Demo.TxnsTest do
  use Demo.DataCase

  alias Demo.Txns

  describe "txns" do
    alias Demo.Txns.Txn

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def txn_fixture(attrs \\ %{}) do
      {:ok, txn} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Txns.create_txn()

      txn
    end

    test "list_txns/0 returns all txns" do
      txn = txn_fixture()
      assert Txns.list_txns() == [txn]
    end

    test "get_txn!/1 returns the txn with given id" do
      txn = txn_fixture()
      assert Txns.get_txn!(txn.id) == txn
    end

    test "create_txn/1 with valid data creates a txn" do
      assert {:ok, %Txn{} = txn} = Txns.create_txn(@valid_attrs)
    end

    test "create_txn/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Txns.create_txn(@invalid_attrs)
    end

    test "update_txn/2 with valid data updates the txn" do
      txn = txn_fixture()
      assert {:ok, %Txn{} = txn} = Txns.update_txn(txn, @update_attrs)
    end

    test "update_txn/2 with invalid data returns error changeset" do
      txn = txn_fixture()
      assert {:error, %Ecto.Changeset{}} = Txns.update_txn(txn, @invalid_attrs)
      assert txn == Txns.get_txn!(txn.id)
    end

    test "delete_txn/1 deletes the txn" do
      txn = txn_fixture()
      assert {:ok, %Txn{}} = Txns.delete_txn(txn)
      assert_raise Ecto.NoResultsError, fn -> Txns.get_txn!(txn.id) end
    end

    test "change_txn/1 returns a txn changeset" do
      txn = txn_fixture()
      assert %Ecto.Changeset{} = Txns.change_txn(txn)
    end
  end
end
