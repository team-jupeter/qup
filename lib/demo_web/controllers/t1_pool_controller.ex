defmodule DemoWeb.T1PoolController do
  use DemoWeb, :controller

  alias Demo.T1Pools
  alias Demo.T1Pools.T1Pool

  def index(conn, _params) do
    t1_pools = T1Pools.list_t1_pools()
    render(conn, "index.html", t1_pools: t1_pools)
  end

  def new(conn, _params) do
    changeset = T1Pools.change_t1_pool(%T1Pool{})
    render(conn, "new.html", changeset: changeset)
  end 

  def create(conn, %{"t1_pool" => t1_pool_params}) do
    case T1Pools.create_t1_pool(t1_pool_params) do
      {:ok, t1_pool} ->
        conn
        |> put_flash(:info, "T1 pool created successfully.")
        |> redirect(to: Routes.t1_pool_path(conn, :show, t1_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t1_pool = T1Pools.get_t1_pool!(id)
    render(conn, "show.html", t1_pool: t1_pool)
  end

  def edit(conn, %{"id" => id}) do
    t1_pool = T1Pools.get_t1_pool!(id)
    changeset = T1Pools.change_t1_pool(t1_pool)
    render(conn, "edit.html", t1_pool: t1_pool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t1_pool" => t1_pool_params}) do
    t1_pool = T1Pools.get_t1_pool!(id)

    case T1Pools.update_t1_pool(t1_pool, t1_pool_params) do
      {:ok, t1_pool} ->
        conn
        |> put_flash(:info, "T1 pool updated successfully.")
        |> redirect(to: Routes.t1_pool_path(conn, :show, t1_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t1_pool: t1_pool, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    t1_pool = T1Pools.get_t1_pool!(id)
    {:ok, _t1_pool} = T1Pools.delete_t1_pool(t1_pool)

    conn
    |> put_flash(:info, "T1 pool deleted successfully.")
    |> redirect(to: Routes.t1_pool_path(conn, :index))
  end
end
