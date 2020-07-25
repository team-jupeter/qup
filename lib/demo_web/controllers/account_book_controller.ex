defmodule DemoWeb.AccountBookController do
  use DemoWeb, :controller

  alias Demo.AccountBooks
  alias Demo.AccountBooks.AccountBook

  def index(conn, _params) do
    account_books = AccountBooks.list_account_books()
    render(conn, "index.html", account_books: account_books)
  end

  def new(conn, _params) do
    changeset = AccountBooks.change_account_book(%AccountBook{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account_book" => account_book_params}) do
    case AccountBooks.create_account_book(account_book_params) do
      {:ok, account_book} ->
        conn
        |> put_flash(:info, "Account book created successfully.")
        |> redirect(to: Routes.account_book_path(conn, :show, account_book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account_book = AccountBooks.get_account_book!(id)
    render(conn, "show.html", account_book: account_book)
  end

  def edit(conn, %{"id" => id}) do
    account_book = AccountBooks.get_account_book!(id)
    changeset = AccountBooks.change_account_book(account_book)
    render(conn, "edit.html", account_book: account_book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account_book" => account_book_params}) do
    account_book = AccountBooks.get_account_book!(id)

    case AccountBooks.update_account_book(account_book, account_book_params) do
      {:ok, account_book} ->
        conn
        |> put_flash(:info, "Account book updated successfully.")
        |> redirect(to: Routes.account_book_path(conn, :show, account_book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", account_book: account_book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account_book = AccountBooks.get_account_book!(id)
    {:ok, _account_book} = AccountBooks.delete_account_book(account_book)

    conn
    |> put_flash(:info, "Account book deleted successfully.")
    |> redirect(to: Routes.account_book_path(conn, :index))
  end
end
