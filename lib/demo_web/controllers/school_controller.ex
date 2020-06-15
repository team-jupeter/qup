defmodule DemoWeb.SchoolController do
  use DemoWeb, :controller

  alias Demo.Campus
  alias Demo.Campus.School

  def index(conn, _params) do
    schools = Campus.list_schools()
    render(conn, "index.html", schools: schools)
  end

  def new(conn, _params) do
    changeset = Campus.change_school(%School{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"school" => school_params}) do
    case Campus.create_school(school_params) do
      {:ok, school} ->
        conn
        |> put_flash(:info, "School created successfully.")
        |> redirect(to: Routes.school_path(conn, :show, school))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    school = Campus.get_school!(id)
    render(conn, "show.html", school: school)
  end

  def edit(conn, %{"id" => id}) do
    school = Campus.get_school!(id)
    changeset = Campus.change_school(school)
    render(conn, "edit.html", school: school, changeset: changeset)
  end

  def update(conn, %{"id" => id, "school" => school_params}) do
    school = Campus.get_school!(id)

    case Campus.update_school(school, school_params) do
      {:ok, school} ->
        conn
        |> put_flash(:info, "School updated successfully.")
        |> redirect(to: Routes.school_path(conn, :show, school))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", school: school, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    school = Campus.get_school!(id)
    {:ok, _school} = Campus.delete_school(school)

    conn
    |> put_flash(:info, "School deleted successfully.")
    |> redirect(to: Routes.school_path(conn, :index))
  end
end
