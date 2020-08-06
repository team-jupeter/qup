defmodule DemoWeb.T4ListController do
  use DemoWeb, :controller

  alias Demo.T4Lists
  alias Demo.T4Lists.T4List

  def index(conn, _params) do
    t4_lists = T4Lists.list_t4_lists()
    render(conn, "index.html", t4_lists: t4_lists)
  end

  def new(conn, _params) do
    changeset = T4Lists.change_t4_list(%T4List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t4_list" => t4_list_params}) do
    case T4Lists.create_t4_list(t4_list_params) do
      {:ok, t4_list} ->
        conn
        |> put_flash(:info, "T4 list created successfully.")
        |> redirect(to: Routes.t4_list_path(conn, :show, t4_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t4_list = T4Lists.get_t4_list!(id)
    render(conn, "show.html", t4_list: t4_list)
  end

  def edit(conn, %{"id" => id}) do
    t4_list = T4Lists.get_t4_list!(id)
    changeset = T4Lists.change_t4_list(t4_list)
    render(conn, "edit.html", t4_list: t4_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t4_list" => t4_list_params}) do
    t4_list = T4Lists.get_t4_list!(id)

    case T4Lists.update_t4_list(t4_list, t4_list_params) do
      {:ok, t4_list} ->
        conn
        |> put_flash(:info, "T4 list updated successfully.")
        |> redirect(to: Routes.t4_list_path(conn, :show, t4_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t4_list: t4_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t4_list = T4Lists.get_t4_list!(id)
    {:ok, _t4_list} = T4Lists.delete_t4_list(t4_list)

    conn
    |> put_flash(:info, "T4 list deleted successfully.")
    |> redirect(to: Routes.t4_list_path(conn, :index))
  end
end
