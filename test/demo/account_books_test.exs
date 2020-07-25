defmodule Demo.AccountBooksTest do
  use Demo.DataCase

  alias Demo.AccountBooks

  describe "account_books" do
    alias Demo.AccountBooks.AccountBook

    @valid_attrs %{grain: "some grain"}
    @update_attrs %{grain: "some updated grain"}
    @invalid_attrs %{grain: nil}

    def account_book_fixture(attrs \\ %{}) do
      {:ok, account_book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AccountBooks.create_account_book()

      account_book
    end

    test "list_account_books/0 returns all account_books" do
      account_book = account_book_fixture()
      assert AccountBooks.list_account_books() == [account_book]
    end

    test "get_account_book!/1 returns the account_book with given id" do
      account_book = account_book_fixture()
      assert AccountBooks.get_account_book!(account_book.id) == account_book
    end

    test "create_account_book/1 with valid data creates a account_book" do
      assert {:ok, %AccountBook{} = account_book} = AccountBooks.create_account_book(@valid_attrs)
      assert account_book.grain == "some grain"
    end

    test "create_account_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AccountBooks.create_account_book(@invalid_attrs)
    end

    test "update_account_book/2 with valid data updates the account_book" do
      account_book = account_book_fixture()
      assert {:ok, %AccountBook{} = account_book} = AccountBooks.update_account_book(account_book, @update_attrs)
      assert account_book.grain == "some updated grain"
    end

    test "update_account_book/2 with invalid data returns error changeset" do
      account_book = account_book_fixture()
      assert {:error, %Ecto.Changeset{}} = AccountBooks.update_account_book(account_book, @invalid_attrs)
      assert account_book == AccountBooks.get_account_book!(account_book.id)
    end

    test "delete_account_book/1 deletes the account_book" do
      account_book = account_book_fixture()
      assert {:ok, %AccountBook{}} = AccountBooks.delete_account_book(account_book)
      assert_raise Ecto.NoResultsError, fn -> AccountBooks.get_account_book!(account_book.id) end
    end

    test "change_account_book/1 returns a account_book changeset" do
      account_book = account_book_fixture()
      assert %Ecto.Changeset{} = AccountBooks.change_account_book(account_book)
    end
  end
end
