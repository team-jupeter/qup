defmodule DemoWeb.ConstitutionController do
  use DemoWeb, :controller

  alias Demo.Constitutions
  alias Demo.Votes.Constitution

  def index(conn, _params) do
    constitutions = Constitutions.list_constitutions()
    render(conn, "index.html", constitutions: constitutions)
  end

  def new(conn, _params) do
    changeset = Constitutions.change_constitution(%Constitution{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"constitution" => constitution_params}) do
    case Constitutions.create_constitution(constitution_params) do
      {:ok, constitution} ->
        conn
        |> put_flash(:info, "Constitution created successfully.")
        |> redirect(to: Routes.constitution_path(conn, :show, constitution))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    constitution = Constitutions.get_constitution!(id)
    render(conn, "show.html", constitution: constitution)
  end

  def edit(conn, %{"id" => id}) do
    constitution = Constitutions.get_constitution!(id)
    changeset = Constitutions.change_constitution(constitution)
    render(conn, "edit.html", constitution: constitution, changeset: changeset)
  end

  def update(conn, %{"id" => id, "constitution" => constitution_params}) do
    constitution = Constitutions.get_constitution!(id)

    case Constitutions.update_constitution(constitution, constitution_params) do
      {:ok, constitution} ->
        conn
        |> put_flash(:info, "Constitution updated successfully.")
        |> redirect(to: Routes.constitution_path(conn, :show, constitution))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", constitution: constitution, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    constitution = Constitutions.get_constitution!(id)
    {:ok, _constitution} = Constitutions.delete_constitution(constitution)

    conn
    |> put_flash(:info, "Constitution deleted successfully.")
    |> redirect(to: Routes.constitution_path(conn, :index))
  end
end
