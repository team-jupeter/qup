defmodule DemoWeb.T2Controller do
  use DemoWeb, :controller

  alias Demo.T2s
  alias Demo.T2s.T2

  def index(conn, _params) do
    t2s = T2s.list_t2s()
    render(conn, "index.html", t2s: t2s)
  end

  def new(conn, _params) do
    changeset = T2s.change_t2(%T2{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t2" => t2_params}) do
    case T2s.create_t2(t2_params) do
      {:ok, t2} ->
        conn
        |> put_flash(:info, "T2 list created successfully.")
        |> redirect(to: Routes.t2_path(conn, :show, t2))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t2 = T2s.get_t2!(id)
    render(conn, "show.html", t2: t2)
  end

  def edit(conn, %{"id" => id}) do
    t2 = T2s.get_t2!(id)
    changeset = T2s.change_t2(t2)
    render(conn, "edit.html", t2: t2, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t2" => t2_params}) do
    t2 = T2s.get_t2!(id)

    case T2s.update_t2(t2, t2_params) do
      {:ok, t2} ->
        conn
        |> put_flash(:info, "T2 list updated successfully.")
        |> redirect(to: Routes.t2_path(conn, :show, t2))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t2: t2, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t2 = T2s.get_t2!(id)
    {:ok, _t2} = T2s.delete_t2(t2)

    conn
    |> put_flash(:info, "T2 list deleted successfully.")
    |> redirect(to: Routes.t2_path(conn, :index))
  end
end
