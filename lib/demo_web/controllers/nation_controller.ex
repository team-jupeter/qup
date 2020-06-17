defmodule DemoWeb.NationController do
  use DemoWeb, :controller

  alias Demo.Nations
  alias Demo.Nations.Nation

  def index(conn, _params) do
    nations = Nations.list_nations()
    render(conn, "index.html", nations: nations)
  end

  def new(conn, _params) do
    changeset = Nations.change_nation(%Nation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"nation" => nation_params}) do
    case Nations.create_nation(nation_params) do
      {:ok, nation} ->
        conn
        |> put_flash(:info, "Nation created successfully.")
        |> redirect(to: Routes.nation_path(conn, :show, nation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    nation = Nations.get_nation!(id)
    render(conn, "show.html", nation: nation)
  end

  def edit(conn, %{"id" => id}) do
    nation = Nations.get_nation!(id)
    changeset = Nations.change_nation(nation)
    render(conn, "edit.html", nation: nation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nation" => nation_params}) do
    nation = Nations.get_nation!(id)

    case Nations.update_nation(nation, nation_params) do
      {:ok, nation} ->
        conn
        |> put_flash(:info, "Nation updated successfully.")
        |> redirect(to: Routes.nation_path(conn, :show, nation))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", nation: nation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    nation = Nations.get_nation!(id)
    {:ok, _nation} = Nations.delete_nation(nation)

    conn
    |> put_flash(:info, "Nation deleted successfully.")
    |> redirect(to: Routes.nation_path(conn, :index))
  end
end
