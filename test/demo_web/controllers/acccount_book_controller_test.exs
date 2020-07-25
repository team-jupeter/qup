defmodule DemoWeb.AccountBookControllerTest do
  use DemoWeb.ConnCase

  alias Demo.AccountBooks

  @create_attrs %{grain: "some grain"}
  @update_attrs %{grain: "some updated grain"}
  @invalid_attrs %{grain: nil}

  def fixture(:account_book) do
    {:ok, account_book} = AccountBooks.create_account_book(@create_attrs)
    account_book
  end

  describe "index" do
    test "lists all account_books", %{conn: conn} do
      conn = get(conn, Routes.account_book_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Account books"
    end
  end

  describe "new account_book" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.account_book_path(conn, :new))
      assert html_response(conn, 200) =~ "New Account book"
    end
  end

  describe "create account_book" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_book_path(conn, :create), account_book: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.account_book_path(conn, :show, id)

      conn = get(conn, Routes.account_book_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Account book"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_book_path(conn, :create), account_book: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Account book"
    end
  end

  describe "edit account_book" do
    setup [:create_account_book]

    test "renders form for editing chosen account_book", %{conn: conn, account_book: account_book} do
      conn = get(conn, Routes.account_book_path(conn, :edit, account_book))
      assert html_response(conn, 200) =~ "Edit Account book"
    end
  end

  describe "update account_book" do
    setup [:create_account_book]

    test "redirects when data is valid", %{conn: conn, account_book: account_book} do
      conn = put(conn, Routes.account_book_path(conn, :update, account_book), account_book: @update_attrs)
      assert redirected_to(conn) == Routes.account_book_path(conn, :show, account_book)

      conn = get(conn, Routes.account_book_path(conn, :show, account_book))
      assert html_response(conn, 200) =~ "some updated grain"
    end

    test "renders errors when data is invalid", %{conn: conn, account_book: account_book} do
      conn = put(conn, Routes.account_book_path(conn, :update, account_book), account_book: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Account book"
    end
  end

  describe "delete account_book" do
    setup [:create_account_book]

    test "deletes chosen account_book", %{conn: conn, account_book: account_book} do
      conn = delete(conn, Routes.account_book_path(conn, :delete, account_book))
      assert redirected_to(conn) == Routes.account_book_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.account_book_path(conn, :show, account_book))
      end
    end
  end

  defp create_account_book(_) do
    account_book = fixture(:account_book)
    {:ok, account_book: account_book}
  end
end
