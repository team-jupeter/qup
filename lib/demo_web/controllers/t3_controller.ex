defmodule DemoWeb.T3Controller do
  use DemoWeb, :controller

  alias Demo.T3s
  alias Demo.T3s.T3

  def index(conn, _params) do
    t3s = T3s.list_t3s()
    render(conn, "index.html", t3s: t3s)
  end

  def new(conn, _params) do
    changeset = T3s.change_t3(%T3{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t3" => t3_params}) do
    case T3s.create_t3(t3_params) do
      {:ok, t3} ->
        conn
        |> put_flash(:info, "T3 created successfully.")
        |> redirect(to: Routes.t3_path(conn, :show, t3))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t3 = T3s.get_t3!(id)
    render(conn, "show.html", t3: t3)
  end

  def edit(conn, %{"id" => id}) do
    t3 = T3s.get_t3!(id)
    changeset = T3s.change_t3(t3)
    render(conn, "edit.html", t3: t3, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t3" => t3_params}) do
    t3 = T3s.get_t3!(id)

    case T3s.update_t3(t3, t3_params) do
      {:ok, t3} ->
        conn
        |> put_flash(:info, "T3 updated successfully.")
        |> redirect(to: Routes.t3_path(conn, :show, t3))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t3: t3, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t3 = T3s.get_t3!(id)
    {:ok, _t3} = T3s.delete_t3(t3)

    conn
    |> put_flash(:info, "T3 deleted successfully.")
    |> redirect(to: Routes.t3_path(conn, :index))
  end
end
