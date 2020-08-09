defmodule DemoWeb.T1Controller do
  use DemoWeb, :controller

  alias Demo.T1s
  alias Demo.T1s.T1

  def index(conn, _params) do
    t1s = T1s.list_t1s()
    render(conn, "index.html", t1s: t1s)
  end

  def new(conn, _params) do
    changeset = T1s.change_t1(%T1{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t1" => t1_params}) do
    case T1s.create_t1(t1_params) do
      {:ok, t1} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: Routes.t1_path(conn, :show, t1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t1 = T1s.get_t1!(id)
    render(conn, "show.html", t1: t1)
  end

  def edit(conn, %{"id" => id}) do
    t1 = T1s.get_t1!(id)
    changeset = T1s.change_t1(t1)
    render(conn, "edit.html", t1: t1, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t1" => t1_params}) do
    t1 = T1s.get_t1!(id)

    case T1s.update_t1(t1, t1_params) do
      {:ok, t1} ->
        conn
        |> put_flash(:info, "T1 list updated successfully.")
        |> redirect(to: Routes.t1_path(conn, :show, t1))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t1: t1, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t1 = T1s.get_t1!(id)
    {:ok, _t1} = T1s.delete_t1(t1)

    conn
    |> put_flash(:info, "T1 list deleted successfully.")
    |> redirect(to: Routes.t1_path(conn, :index))
  end
end
