defmodule DemoWeb.T3ListController do
  use DemoWeb, :controller

  alias Demo.T3Lists
  alias Demo.T3Lists.T3List

  def index(conn, _params) do
    t3_lists = T3Lists.list_t3_lists()
    render(conn, "index.html", t3_lists: t3_lists)
  end

  def new(conn, _params) do
    changeset = T3Lists.change_t3_list(%T3List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t3_list" => t3_list_params}) do
    case T3Lists.create_t3_list(t3_list_params) do
      {:ok, t3_list} ->
        conn
        |> put_flash(:info, "T3 list created successfully.")
        |> redirect(to: Routes.t3_list_path(conn, :show, t3_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t3_list = T3Lists.get_t3_list!(id)
    render(conn, "show.html", t3_list: t3_list)
  end

  def edit(conn, %{"id" => id}) do
    t3_list = T3Lists.get_t3_list!(id)
    changeset = T3Lists.change_t3_list(t3_list)
    render(conn, "edit.html", t3_list: t3_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t3_list" => t3_list_params}) do
    t3_list = T3Lists.get_t3_list!(id)

    case T3Lists.update_t3_list(t3_list, t3_list_params) do
      {:ok, t3_list} ->
        conn
        |> put_flash(:info, "T3 list updated successfully.")
        |> redirect(to: Routes.t3_list_path(conn, :show, t3_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t3_list: t3_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t3_list = T3Lists.get_t3_list!(id)
    {:ok, _t3_list} = T3Lists.delete_t3_list(t3_list)

    conn
    |> put_flash(:info, "T3 list deleted successfully.")
    |> redirect(to: Routes.t3_list_path(conn, :index))
  end
end
