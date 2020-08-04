defmodule DemoWeb.TelController do
  use DemoWeb, :controller

  alias Demo.Tels
  alias Demo.Tels.Tel

  def index(conn, _params) do
    tels = Tels.list_tels()
    render(conn, "index.html", tels: tels)
  end

  def new(conn, _params) do
    changeset = Tels.change_tel(%Tel{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tel" => tel_params}) do
    case Tels.create_tel(tel_params) do
      {:ok, tel} ->
        conn
        |> put_flash(:info, "Tel created successfully.")
        |> redirect(to: Routes.tel_path(conn, :show, tel))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tel = Tels.get_tel!(id)
    render(conn, "show.html", tel: tel)
  end

  def edit(conn, %{"id" => id}) do
    tel = Tels.get_tel!(id)
    changeset = Tels.change_tel(tel)
    render(conn, "edit.html", tel: tel, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tel" => tel_params}) do
    tel = Tels.get_tel!(id)

    case Tels.update_tel(tel, tel_params) do
      {:ok, tel} ->
        conn
        |> put_flash(:info, "Tel updated successfully.")
        |> redirect(to: Routes.tel_path(conn, :show, tel))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tel: tel, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tel = Tels.get_tel!(id)
    {:ok, _tel} = Tels.delete_tel(tel)

    conn
    |> put_flash(:info, "Tel deleted successfully.")
    |> redirect(to: Routes.tel_path(conn, :index))
  end
end
