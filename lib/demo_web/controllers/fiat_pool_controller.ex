defmodule DemoWeb.FiatPoolController do
  use DemoWeb, :controller

  alias Demo.FiatPools
  alias Demo.FiatPools.FiatPool

  def index(conn, _params) do
    fiat_pools = FiatPools.list_fiat_pools()
    render(conn, "index.html", fiat_pools: fiat_pools)
  end

  def new(conn, _params) do
    changeset = FiatPools.change_fiat_pool(%FiatPool{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"fiat_pool" => fiat_pool_params}) do
    case FiatPools.create_fiat_pool(fiat_pool_params) do
      {:ok, fiat_pool} ->
        conn
        |> put_flash(:info, "Fiat pool created successfully.")
        |> redirect(to: Routes.fiat_pool_path(conn, :show, fiat_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    fiat_pool = FiatPools.get_fiat_pool!(id)
    render(conn, "show.html", fiat_pool: fiat_pool)
  end

  def edit(conn, %{"id" => id}) do
    fiat_pool = FiatPools.get_fiat_pool!(id)
    changeset = FiatPools.change_fiat_pool(fiat_pool)
    render(conn, "edit.html", fiat_pool: fiat_pool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "fiat_pool" => fiat_pool_params}) do
    fiat_pool = FiatPools.get_fiat_pool!(id)

    case FiatPools.update_fiat_pool(fiat_pool, fiat_pool_params) do
      {:ok, fiat_pool} ->
        conn
        |> put_flash(:info, "Fiat pool updated successfully.")
        |> redirect(to: Routes.fiat_pool_path(conn, :show, fiat_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", fiat_pool: fiat_pool, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    fiat_pool = FiatPools.get_fiat_pool!(id)
    {:ok, _fiat_pool} = FiatPools.delete_fiat_pool(fiat_pool)

    conn
    |> put_flash(:info, "Fiat pool deleted successfully.")
    |> redirect(to: Routes.fiat_pool_path(conn, :index))
  end
end
