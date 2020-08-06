defmodule DemoWeb.MoneyPoolController do
  use DemoWeb, :controller

  alias Demo.MoneyPools
  alias Demo.MoneyPools.MoneyPool

  def index(conn, _params) do
    money_pools = MoneyPools.list_money_pools()
    render(conn, "index.html", money_pools: money_pools)
  end

  def new(conn, _params) do
    changeset = MoneyPools.change_money_pool(%MoneyPool{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"money_pool" => money_pool_params}) do
    case MoneyPools.create_money_pool(money_pool_params) do
      {:ok, money_pool} ->
        conn
        |> put_flash(:info, "Money pool created successfully.")
        |> redirect(to: Routes.money_pool_path(conn, :show, money_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    money_pool = MoneyPools.get_money_pool!(id)
    render(conn, "show.html", money_pool: money_pool)
  end

  def edit(conn, %{"id" => id}) do
    money_pool = MoneyPools.get_money_pool!(id)
    changeset = MoneyPools.change_money_pool(money_pool)
    render(conn, "edit.html", money_pool: money_pool, changeset: changeset)
  end

  def update(conn, %{"id" => id, "money_pool" => money_pool_params}) do
    money_pool = MoneyPools.get_money_pool!(id)

    case MoneyPools.update_money_pool(money_pool, money_pool_params) do
      {:ok, money_pool} ->
        conn
        |> put_flash(:info, "Money pool updated successfully.")
        |> redirect(to: Routes.money_pool_path(conn, :show, money_pool))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", money_pool: money_pool, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    money_pool = MoneyPools.get_money_pool!(id)
    {:ok, _money_pool} = MoneyPools.delete_money_pool(money_pool)

    conn
    |> put_flash(:info, "Money pool deleted successfully.")
    |> redirect(to: Routes.money_pool_path(conn, :index))
  end
end
