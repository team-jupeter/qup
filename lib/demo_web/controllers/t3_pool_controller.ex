defmodule DemoWeb.T3PoolController do
  use DemoWeb, :controller

  alias Demo.T3Pools
  alias Demo.T3Pools.T3Pool

  def index(conn, _params) do
    t3_pools = T3Pools.list_t3_pools()
    render(conn, "index.html", t3_pools: t3_pools)
  end

  def new(conn, _params) do
    changeset = T3Pools.change_t3_pool(%T3Pool{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"t3_pool" => t3_pool_params}) do
    case T3Pools.create_t3_pool(t3_pool_params) do
      {:ok, t3_pool} ->
        conn
        |> put_flash(:info, "T3 pool created successfully.")
        |> redirect(to: Routes.t3_pool_path(conn, :show, t3_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    t3_pool = T3Pools.get_t3_pool!(id)
    render(conn, "show.html", t3_pool: t3_pool)
  end

  def edit(conn, %{"id" => id}) do
    t3_pool = T3Pools.get_t3_pool!(id)
    changeset = T3Pools.change_t3_pool(t3_pool)
    render(conn, "edit.html", t3_pool: t3_pool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "t3_pool" => t3_pool_params}) do
    t3_pool = T3Pools.get_t3_pool!(id)

    case T3Pools.update_t3_pool(t3_pool, t3_pool_params) do
      {:ok, t3_pool} ->
        conn
        |> put_flash(:info, "T3 pool updated successfully.")
        |> redirect(to: Routes.t3_pool_path(conn, :show, t3_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", t3_pool: t3_pool, changeset: changeset)
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   t3_pool = T3Pools.get_t3_pool!(id)
  #   {:ok, _t3_pool} = T3Pools.delete_t3_pool(t3_pool)

  #   conn
  #   |> put_flash(:info, "T3 pool deleted successfully.")
  #   |> redirect(to: Routes.t3_pool_path(conn, :index))
  # end
end
