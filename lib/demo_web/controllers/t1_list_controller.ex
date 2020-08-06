defmodule DemoWeb.T1ListController do
  use DemoWeb, :controller

  alias Demo.T1Lists
  alias Demo.T1Lists.T1List

  def index(conn, _params) do
    t1_lists = T1Lists.list_t1_lists()
    render(conn, "index.html", t1_lists: t1_lists)
  end

  def new(conn, _params) do
    changeset = T1Lists.change_t1_list(%T1List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t1_list" => t1_list_params}) do
    case T1Lists.create_t1_list(t1_list_params) do
      {:ok, t1_list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: Routes.t1_list_path(conn, :show, t1_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t1_list = T1Lists.get_t1_list!(id)
    render(conn, "show.html", t1_list: t1_list)
  end

  def edit(conn, %{"id" => id}) do
    t1_list = T1Lists.get_t1_list!(id)
    changeset = T1Lists.change_t1_list(t1_list)
    render(conn, "edit.html", t1_list: t1_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t1_list" => t1_list_params}) do
    t1_list = T1Lists.get_t1_list!(id)

    case T1Lists.update_t1_list(t1_list, t1_list_params) do
      {:ok, t1_list} ->
        conn
        |> put_flash(:info, "T1 list updated successfully.")
        |> redirect(to: Routes.t1_list_path(conn, :show, t1_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t1_list: t1_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t1_list = T1Lists.get_t1_list!(id)
    {:ok, _t1_list} = T1Lists.delete_t1_list(t1_list)

    conn
    |> put_flash(:info, "T1 list deleted successfully.")
    |> redirect(to: Routes.t1_list_path(conn, :index))
  end
end
