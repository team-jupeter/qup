defmodule DemoWeb.T2PoolController do
  use DemoWeb, :controller

  alias Demo.T2Pools
  alias Demo.T2Pools.T2Pool

  def index(conn, _params) do
    t2_pools = T2Pools.list_t2_pools()
    render(conn, "index.html", t2_pools: t2_pools)
  end

  def new(conn, _params) do
    changeset = T2Pools.change_t2_pool(%T2Pool{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t2_pool" => t2_pool_params}) do
    case T2Pools.create_t2_pool(t2_pool_params) do
      {:ok, t2_pool} ->
        conn
        |> put_flash(:info, "T2 pool created successfully.")
        |> redirect(to: Routes.t2_pool_path(conn, :show, t2_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t2_pool = T2Pools.get_t2_pool!(id)
    render(conn, "show.html", t2_pool: t2_pool)
  end

  def edit(conn, %{"id" => id}) do
    t2_pool = T2Pools.get_t2_pool!(id)
    changeset = T2Pools.change_t2_pool(t2_pool)
    render(conn, "edit.html", t2_pool: t2_pool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t2_pool" => t2_pool_params}) do
    t2_pool = T2Pools.get_t2_pool!(id)

    case T2Pools.update_t2_pool(t2_pool, t2_pool_params) do
      {:ok, t2_pool} ->
        conn
        |> put_flash(:info, "T2 pool updated successfully.")
        |> redirect(to: Routes.t2_pool_path(conn, :show, t2_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t2_pool: t2_pool, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t2_pool = T2Pools.get_t2_pool!(id)
    {:ok, _t2_pool} = T2Pools.delete_t2_pool(t2_pool)

    conn
    |> put_flash(:info, "T2 pool deleted successfully.")
    |> redirect(to: Routes.t2_pool_path(conn, :index))
  end
end
