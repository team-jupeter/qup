defmodule DemoWeb.T4Controller do
  use DemoWeb, :controller

  alias Demo.T4s
  alias Demo.T4s.T4

  def index(conn, _params) do
    t4s = T4s.list_t4s()
    render(conn, "index.html", t4s: t4s)
  end

  def new(conn, _params) do
    changeset = T4s.change_t4(%T4{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t4" => t4_params}) do
    case T4s.create_t4(t4_params) do
      {:ok, t4} ->
        conn
        |> put_flash(:info, "T4 list created successfully.")
        |> redirect(to: Routes.t4_path(conn, :show, t4))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t4 = T4s.get_t4!(id)
    render(conn, "show.html", t4: t4)
  end

  def edit(conn, %{"id" => id}) do
    t4 = T4s.get_t4!(id)
    changeset = T4s.change_t4(t4)
    render(conn, "edit.html", t4: t4, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t4" => t4_params}) do
    t4 = T4s.get_t4!(id)

    case T4s.update_t4(t4, t4_params) do
      {:ok, t4} ->
        conn
        |> put_flash(:info, "T4 list updated successfully.")
        |> redirect(to: Routes.t4_path(conn, :show, t4))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t4: t4, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t4 = T4s.get_t4!(id)
    {:ok, _t4} = T4s.delete_t4(t4)

    conn
    |> put_flash(:info, "T4 list deleted successfully.")
    |> redirect(to: Routes.t4_path(conn, :index))
  end
end
