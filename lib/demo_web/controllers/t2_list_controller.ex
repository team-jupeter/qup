defmodule DemoWeb.T2ListController do
  use DemoWeb, :controller

  alias Demo.T2Lists
  alias Demo.T2Lists.T2List

  def index(conn, _params) do
    t2_lists = T2Lists.list_t2_lists()
    render(conn, "index.html", t2_lists: t2_lists)
  end

  def new(conn, _params) do
    changeset = T2Lists.change_t2_list(%T2List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t2_list" => t2_list_params}) do
    case T2Lists.create_t2_list(t2_list_params) do
      {:ok, t2_list} ->
        conn
        |> put_flash(:info, "T2 list created successfully.")
        |> redirect(to: Routes.t2_list_path(conn, :show, t2_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t2_list = T2Lists.get_t2_list!(id)
    render(conn, "show.html", t2_list: t2_list)
  end

  def edit(conn, %{"id" => id}) do
    t2_list = T2Lists.get_t2_list!(id)
    changeset = T2Lists.change_t2_list(t2_list)
    render(conn, "edit.html", t2_list: t2_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t2_list" => t2_list_params}) do
    t2_list = T2Lists.get_t2_list!(id)

    case T2Lists.update_t2_list(t2_list, t2_list_params) do
      {:ok, t2_list} ->
        conn
        |> put_flash(:info, "T2 list updated successfully.")
        |> redirect(to: Routes.t2_list_path(conn, :show, t2_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t2_list: t2_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t2_list = T2Lists.get_t2_list!(id)
    {:ok, _t2_list} = T2Lists.delete_t2_list(t2_list)

    conn
    |> put_flash(:info, "T2 list deleted successfully.")
    |> redirect(to: Routes.t2_list_path(conn, :index))
  end
end
