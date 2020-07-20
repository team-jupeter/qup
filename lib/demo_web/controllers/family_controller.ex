defmodule DemoWeb.FamilyController do
  use DemoWeb, :controller

  alias Demo.Families
  alias Demo.Families.Family

  def index(conn, _params) do
    families = Families.list_families()
    render(conn, "index.html", families: families)
  end

  def new(conn, _params) do
    changeset = Families.change_family(%Family{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"family" => family_params}) do
    case Families.create_family(family_params) do
      {:ok, family} ->
        conn
        |> put_flash(:info, "Family created successfully.")
        |> redirect(to: Routes.family_path(conn, :show, family))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    family = Families.get_family!(id)
    render(conn, "show.html", family: family)
  end

  def edit(conn, %{"id" => id}) do
    family = Families.get_family!(id)
    changeset = Families.change_family(family)
    render(conn, "edit.html", family: family, changeset: changeset)
  end

  def update(conn, %{"id" => id, "family" => family_params}) do
    family = Families.get_family!(id)

    case Families.update_family(family, family_params) do
      {:ok, family} ->
        conn
        |> put_flash(:info, "Family updated successfully.")
        |> redirect(to: Routes.family_path(conn, :show, family))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", family: family, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    family = Families.get_family!(id)
    {:ok, _family} = Families.delete_family(family)

    conn
    |> put_flash(:info, "Family deleted successfully.")
    |> redirect(to: Routes.family_path(conn, :index))
  end
end
