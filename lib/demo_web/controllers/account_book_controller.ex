defmodule DemoWeb.AccountBookController do
  use DemoWeb, :controller

  alias Demo.AccountBooks
  alias Demo.AccountBooks.AccountBook
  alias Demo.Repo
  alias Demo.Families
  alias Demo.Supuls
  # alias Demo.Supuls.Supul
  alias Demo.StateSupuls
  alias Demo.NationSupuls

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
    IO.puts("account_book")
    account_book = AccountBooks.get_entity_account_book(id)
    render(conn, "show.html", account_book: account_book)
  end

  def edit(conn, %{"id" => id}) do
    account_book =
      cond do
        Families.get_family(id) != nil ->
          family = Families.get_family(id)
          Repo.preload(family, :account_book).account_book

        Supuls.get_supul(id) != nil ->
          supul = Supuls.get_supul(id)
          Repo.preload(supul, :account_book).account_book

        StateSupuls.get_state_supul(id) != nil ->
          state_supul = StateSupuls.get_state_supul(id)
          Repo.preload(state_supul, :account_book).account_book

        NationSupuls.get_nation_supul(id) != nil ->
          nation_supul = NationSupuls.get_nation_supul(id)
          Repo.preload(nation_supul, :account_book).account_book

        true ->
          "error"
      end

    render(conn, "show.html", account_book: account_book)
  end

  # def supul(conn, supul) do
  #   account_book = Repo.preload(supul, :account_book).account_book
  #   render(conn, "show.html", account_book: account_book)
  # end

  # def state_supul(conn, state_supul) do
  #   IO.inspect state_supul
  #   account_book = Repo.preload(state_supul, :account_book).account_book
  #   render(conn, "show.html", account_book: account_book)
  # end

  # def nation_supul(conn, nation_supul) do
  #   account_book = Repo.preload(nation_supul, :account_book).account_book
  #   render(conn, "show.html", account_book: account_book)
  # end

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
