defmodule DemoWeb.NationSupulController do
  use DemoWeb, :controller

  alias Demo.NationSupuls
  alias Demo.NationSupuls.NationSupul

  def index(conn, _params) do
    nation_supuls = NationSupuls.list_nation_supuls()
    render(conn, "index.html", nation_supuls: nation_supuls)
  end

  def new(conn, _params) do
    changeset = NationSupuls.change_nation_supul(%NationSupul{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"nation_supul" => nation_supul_params}) do
    case NationSupuls.create_nation_supul(nation_supul_params) do
      {:ok, nation_supul} ->
        conn
        |> put_flash(:info, "Nation supul created successfully.")
        |> redirect(to: Routes.nation_supul_path(conn, :show, nation_supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    nation_supul = NationSupuls.get_nation_supul!(id)
    render(conn, "show.html", nation_supul: nation_supul)
  end

  def edit(conn, %{"id" => id}) do
    nation_supul = NationSupuls.get_nation_supul!(id)
    changeset = NationSupuls.change_nation_supul(nation_supul)
    render(conn, "edit.html", nation_supul: nation_supul, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nation_supul" => nation_supul_params}) do
    nation_supul = NationSupuls.get_nation_supul!(id)

    case NationSupuls.update_nation_supul(nation_supul, nation_supul_params) do
      {:ok, nation_supul} ->
        conn
        |> put_flash(:info, "Nation supul updated successfully.")
        |> redirect(to: Routes.nation_supul_path(conn, :show, nation_supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", nation_supul: nation_supul, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    nation_supul = NationSupuls.get_nation_supul!(id)
    {:ok, _nation_supul} = NationSupuls.delete_nation_supul(nation_supul)

    conn
    |> put_flash(:info, "Nation supul deleted successfully.")
    |> redirect(to: Routes.nation_supul_path(conn, :index))
  end
end
