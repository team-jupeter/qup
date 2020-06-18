defmodule DemoWeb.GlobalSupulController do
  use DemoWeb, :controller

  alias Demo.GlobalSupuls
  alias Demo.Supuls.GlobalSupul

  def index(conn, _params) do
    global_supuls = GlobalSupuls.list_global_supuls()
    render(conn, "index.html", global_supuls: global_supuls)
  end

  def new(conn, _params) do
    changeset = GlobalSupuls.change_global_supul(%GlobalSupul{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"global_supul" => global_supul_params}) do
    case GlobalSupuls.create_global_supul(global_supul_params) do
      {:ok, global_supul} ->
        conn
        |> put_flash(:info, "Global supul created successfully.")
        |> redirect(to: Routes.global_supul_path(conn, :show, global_supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    global_supul = GlobalSupuls.get_global_supul!(id)
    render(conn, "show.html", global_supul: global_supul)
  end

  def edit(conn, %{"id" => id}) do
    global_supul = GlobalSupuls.get_global_supul!(id)
    changeset = GlobalSupuls.change_global_supul(global_supul)
    render(conn, "edit.html", global_supul: global_supul, changeset: changeset)
  end

  def update(conn, %{"id" => id, "global_supul" => global_supul_params}) do
    global_supul = GlobalSupuls.get_global_supul!(id)

    case GlobalSupuls.update_global_supul(global_supul, global_supul_params) do
      {:ok, global_supul} ->
        conn
        |> put_flash(:info, "Global supul updated successfully.")
        |> redirect(to: Routes.global_supul_path(conn, :show, global_supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", global_supul: global_supul, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    global_supul = GlobalSupuls.get_global_supul!(id)
    {:ok, _global_supul} = GlobalSupuls.delete_global_supul(global_supul)

    conn
    |> put_flash(:info, "Global supul deleted successfully.")
    |> redirect(to: Routes.global_supul_path(conn, :index))
  end
end
