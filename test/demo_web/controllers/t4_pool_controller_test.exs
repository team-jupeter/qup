defmodule DemoWeb.T4PoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T4Pools

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:t4_pool) do
    {:ok, t4_pool} = T4Pools.create_t4_pool(@create_attrs)
    t4_pool
  end

  describe "index" do
    test "lists all t4_pools", %{conn: conn} do
      conn = get(conn, Routes.t4_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T4 pools"
    end
  end

  describe "new t4_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t4_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New T4 pool"
    end
  end

  describe "create t4_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t4_pool_path(conn, :create), t4_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t4_pool_path(conn, :show, id)

      conn = get(conn, Routes.t4_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T4 pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t4_pool_path(conn, :create), t4_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T4 pool"
    end
  end

  describe "edit t4_pool" do
    setup [:create_t4_pool]

    test "renders form for editing chosen t4_pool", %{conn: conn, t4_pool: t4_pool} do
      conn = get(conn, Routes.t4_pool_path(conn, :edit, t4_pool))
      assert html_response(conn, 200) =~ "Edit T4 pool"
    end
  end

  describe "update t4_pool" do
    setup [:create_t4_pool]

    test "redirects when data is valid", %{conn: conn, t4_pool: t4_pool} do
      conn = put(conn, Routes.t4_pool_path(conn, :update, t4_pool), t4_pool: @update_attrs)
      assert redirected_to(conn) == Routes.t4_pool_path(conn, :show, t4_pool)

      conn = get(conn, Routes.t4_pool_path(conn, :show, t4_pool))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, t4_pool: t4_pool} do
      conn = put(conn, Routes.t4_pool_path(conn, :update, t4_pool), t4_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T4 pool"
    end
  end

  describe "delete t4_pool" do
    setup [:create_t4_pool]

    test "deletes chosen t4_pool", %{conn: conn, t4_pool: t4_pool} do
      conn = delete(conn, Routes.t4_pool_path(conn, :delete, t4_pool))
      assert redirected_to(conn) == Routes.t4_pool_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t4_pool_path(conn, :show, t4_pool))
      end
    end
  end

  defp create_t4_pool(_) do
    t4_pool = fixture(:t4_pool)
    {:ok, t4_pool: t4_pool}
  end
end
