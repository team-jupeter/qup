defmodule DemoWeb.T4PoolController do
  use DemoWeb, :controller

  alias Demo.T4Pools
  alias Demo.T4Pools.T4Pool

  def index(conn, _params) do
    t4_pools = T4Pools.list_t4_pools()
    render(conn, "index.html", t4_pools: t4_pools)
  end

  def new(conn, _params) do
    changeset = T4Pools.change_t4_pool(%T4Pool{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t4_pool" => t4_pool_params}) do
    case T4Pools.create_t4_pool(t4_pool_params) do
      {:ok, t4_pool} ->
        conn
        |> put_flash(:info, "T4 pool created successfully.")
        |> redirect(to: Routes.t4_pool_path(conn, :show, t4_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t4_pool = T4Pools.get_t4_pool!(id)
    render(conn, "show.html", t4_pool: t4_pool)
  end

  def edit(conn, %{"id" => id}) do
    t4_pool = T4Pools.get_t4_pool!(id)
    changeset = T4Pools.change_t4_pool(t4_pool)
    render(conn, "edit.html", t4_pool: t4_pool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t4_pool" => t4_pool_params}) do
    t4_pool = T4Pools.get_t4_pool!(id)

    case T4Pools.update_t4_pool(t4_pool, t4_pool_params) do
      {:ok, t4_pool} ->
        conn
        |> put_flash(:info, "T4 pool updated successfully.")
        |> redirect(to: Routes.t4_pool_path(conn, :show, t4_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t4_pool: t4_pool, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t4_pool = T4Pools.get_t4_pool!(id)
    {:ok, _t4_pool} = T4Pools.delete_t4_pool(t4_pool)

    conn
    |> put_flash(:info, "T4 pool deleted successfully.")
    |> redirect(to: Routes.t4_pool_path(conn, :index))
  end
end
