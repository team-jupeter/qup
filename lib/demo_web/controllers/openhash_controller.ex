defmodule DemoWeb.OpenhashController do
  use DemoWeb, :controller

  alias Demo.Openhashes
  alias Demo.Openhashes.Openhash

  def index(conn, _params) do
    openhashes = Openhashes.list_openhashes()
    render(conn, "index.html", openhashes: openhashes)
  end

  def new(conn, _params) do
    changeset = Openhashes.change_openhash(%Openhash{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"openhash" => openhash_params}) do
    case Openhashes.create_openhash(openhash_params) do 
      {:ok, openhash} ->
        conn
        |> put_flash(:info, "Openhash created successfully.")
        |> redirect(to: Routes.openhash_path(conn, :show, openhash))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    openhash = Openhashes.get_openhash!(id)
    render(conn, "show.html", openhash: openhash)
  end

  def edit(conn, %{"id" => id}) do
    openhash = Openhashes.get_openhash!(id)
    changeset = Openhashes.change_openhash(openhash)
    render(conn, "edit.html", openhash: openhash, changeset: changeset)
  end

  def update(conn, %{"id" => id, "openhash" => openhash_params}) do
    openhash = Openhashes.get_openhash!(id)

    case Openhashes.update_openhash(openhash, openhash_params) do
      {:ok, openhash} ->
        conn
        |> put_flash(:info, "Openhash updated successfully.")
        |> redirect(to: Routes.openhash_path(conn, :show, openhash))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", openhash: openhash, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    openhash = Openhashes.get_openhash!(id)
    {:ok, _openhash} = Openhashes.delete_openhash(openhash)

    conn
    |> put_flash(:info, "Openhash deleted successfully.")
    |> redirect(to: Routes.openhash_path(conn, :index))
  end
end
