defmodule Demo.TxnsTest do
  use Demo.DataCase

  alias Demo.Txns

  describe "transactions" do
    alias Demo.Txns.Txn

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Txns.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Txns.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Txns.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Txn{} = transaction} = Txns.create_transaction(@valid_attrs)
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Txns.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Txn{} = transaction} = Txns.update_transaction(transaction, @update_attrs)
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Txns.update_transaction(transaction, @invalid_attrs)
      assert transaction == Txns.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Txn{}} = Txns.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Txns.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Txns.change_transaction(transaction)
    end
  end
end
