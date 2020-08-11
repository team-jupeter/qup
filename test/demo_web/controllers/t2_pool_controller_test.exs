defmodule DemoWeb.T2PoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T2Pools

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:t2_pool) do
    {:ok, t2_pool} = T2Pools.create_t2_pool(@create_attrs)
    t2_pool
  end

  describe "index" do
    test "lists all t2_pools", %{conn: conn} do
      conn = get(conn, Routes.t2_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T2 pools"
    end
  end

  describe "new t2_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t2_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New T2 pool"
    end
  end

  describe "create t2_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t2_pool_path(conn, :create), t2_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t2_pool_path(conn, :show, id)

      conn = get(conn, Routes.t2_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T2 pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t2_pool_path(conn, :create), t2_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T2 pool"
    end
  end

  describe "edit t2_pool" do
    setup [:create_t2_pool]

    test "renders form for editing chosen t2_pool", %{conn: conn, t2_pool: t2_pool} do
      conn = get(conn, Routes.t2_pool_path(conn, :edit, t2_pool))
      assert html_response(conn, 200) =~ "Edit T2 pool"
    end
  end

  describe "update t2_pool" do
    setup [:create_t2_pool]

    test "redirects when data is valid", %{conn: conn, t2_pool: t2_pool} do
      conn = put(conn, Routes.t2_pool_path(conn, :update, t2_pool), t2_pool: @update_attrs)
      assert redirected_to(conn) == Routes.t2_pool_path(conn, :show, t2_pool)

      conn = get(conn, Routes.t2_pool_path(conn, :show, t2_pool))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, t2_pool: t2_pool} do
      conn = put(conn, Routes.t2_pool_path(conn, :update, t2_pool), t2_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T2 pool"
    end
  end

  describe "delete t2_pool" do
    setup [:create_t2_pool]

    test "deletes chosen t2_pool", %{conn: conn, t2_pool: t2_pool} do
      conn = delete(conn, Routes.t2_pool_path(conn, :delete, t2_pool))
      assert redirected_to(conn) == Routes.t2_pool_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t2_pool_path(conn, :show, t2_pool))
      end
    end
  end

  defp create_t2_pool(_) do
    t2_pool = fixture(:t2_pool)
    {:ok, t2_pool: t2_pool}
  end
end
