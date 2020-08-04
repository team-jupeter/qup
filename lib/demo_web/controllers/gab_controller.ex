defmodule DemoWeb.GabController do
  use DemoWeb, :controller

  alias Demo.Gabs
  alias Demo.Gabs.Gab

  def index(conn, _params) do
    gabs = Gabs.list_gabs()
    render(conn, "index.html", gabs: gabs)
  end

  def new(conn, _params) do
    changeset = Gabs.change_gab(%Gab{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"gab" => gab_params}) do
    case Gabs.create_gab(gab_params) do
      {:ok, gab} ->
        conn
        |> put_flash(:info, "Gab created successfully.")
        |> redirect(to: Routes.gab_path(conn, :show, gab))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gab = Gabs.get_gab!(id)
    render(conn, "show.html", gab: gab)
  end

  def edit(conn, %{"id" => id}) do
    gab = Gabs.get_gab!(id)
    changeset = Gabs.change_gab(gab)
    render(conn, "edit.html", gab: gab, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gab" => gab_params}) do
    gab = Gabs.get_gab!(id)

    case Gabs.update_gab(gab, gab_params) do
      {:ok, gab} ->
        conn
        |> put_flash(:info, "Gab updated successfully.")
        |> redirect(to: Routes.gab_path(conn, :show, gab))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", gab: gab, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gab = Gabs.get_gab!(id)
    {:ok, _gab} = Gabs.delete_gab(gab)

    conn
    |> put_flash(:info, "Gab deleted successfully.")
    |> redirect(to: Routes.gab_path(conn, :index))
  end
end
