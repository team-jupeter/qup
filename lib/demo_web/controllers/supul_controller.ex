defmodule DemoWeb.SupulController do
  use DemoWeb, :controller

  alias Demo.Supuls
  alias Demo.Supuls.Supul

  def index(conn, _params) do
    supuls = Supuls.list_supuls()
    render(conn, "index.html", supuls: supuls) 
  end 

  def new(conn, _params) do
    changeset = Supuls.change_supul(%Supul{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supul" => supul_params}) do
    case Supuls.create_supul(supul_params) do 
      {:ok, supul} ->
        conn
        |> put_flash(:info, "Supul created successfully.")
        |> redirect(to: Routes.supul_path(conn, :show, supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supul = Supuls.get_supul!(id)
    render(conn, "show.html", supul: supul)
  end

  def edit(conn, %{"id" => id}) do
    supul = Supuls.get_supul!(id)
    changeset = Supuls.change_supul(supul)
    render(conn, "edit.html", supul: supul, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supul" => supul_params}) do
    supul = Supuls.get_supul!(id)

    case Supuls.update_supul(supul, supul_params) do
      {:ok, supul} ->
        conn
        |> put_flash(:info, "Supul updated successfully.")
        |> redirect(to: Routes.supul_path(conn, :show, supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supul: supul, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supul = Supuls.get_supul!(id)
    {:ok, _supul} = Supuls.delete_supul(supul)

    conn
    |> put_flash(:info, "Supul deleted successfully.")
    |> redirect(to: Routes.supul_path(conn, :index))
  end
end
