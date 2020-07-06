defmodule DemoWeb.JangController do
  use DemoWeb, :controller

  alias Demo.Jangs
  alias Demo.Jangs.Jang

  def index(conn, _params) do
    jangs = Jangs.list_jangs()
    render(conn, "index.html", jangs: jangs)
  end

  def new(conn, _params) do
    changeset = Jangs.change_jang(%Jang{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"jang" => jang_params}) do
    case Jangs.create_jang(jang_params) do
      {:ok, jang} ->
        conn
        |> put_flash(:info, "Jang created successfully.")
        |> redirect(to: Routes.jang_path(conn, :show, jang))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    jang = Jangs.get_jang!(id)
    render(conn, "show.html", jang: jang)
  end

  def edit(conn, %{"id" => id}) do
    jang = Jangs.get_jang!(id)
    changeset = Jangs.change_jang(jang)
    render(conn, "edit.html", jang: jang, changeset: changeset)
  end

  def update(conn, %{"id" => id, "jang" => jang_params}) do
    jang = Jangs.get_jang!(id)

    case Jangs.update_jang(jang, jang_params) do
      {:ok, jang} ->
        conn
        |> put_flash(:info, "Jang updated successfully.")
        |> redirect(to: Routes.jang_path(conn, :show, jang))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", jang: jang, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    jang = Jangs.get_jang!(id)
    {:ok, _jang} = Jangs.delete_jang(jang)

    conn
    |> put_flash(:info, "Jang deleted successfully.")
    |> redirect(to: Routes.jang_path(conn, :index))
  end
end
