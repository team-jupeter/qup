defmodule DemoWeb.T1PoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T1Pools

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:t1_pool) do
    {:ok, t1_pool} = T1Pools.create_t1_pool(@create_attrs)
    t1_pool
  end

  describe "index" do
    test "lists all t1_pools", %{conn: conn} do
      conn = get(conn, Routes.t1_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T1 pools"
    end
  end

  describe "new t1_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t1_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New T1 pool"
    end
  end

  describe "create t1_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t1_pool_path(conn, :create), t1_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t1_pool_path(conn, :show, id)

      conn = get(conn, Routes.t1_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T1 pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t1_pool_path(conn, :create), t1_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T1 pool"
    end
  end

  describe "edit t1_pool" do
    setup [:create_t1_pool]

    test "renders form for editing chosen t1_pool", %{conn: conn, t1_pool: t1_pool} do
      conn = get(conn, Routes.t1_pool_path(conn, :edit, t1_pool))
      assert html_response(conn, 200) =~ "Edit T1 pool"
    end
  end

  describe "update t1_pool" do
    setup [:create_t1_pool]

    test "redirects when data is valid", %{conn: conn, t1_pool: t1_pool} do
      conn = put(conn, Routes.t1_pool_path(conn, :update, t1_pool), t1_pool: @update_attrs)
      assert redirected_to(conn) == Routes.t1_pool_path(conn, :show, t1_pool)

      conn = get(conn, Routes.t1_pool_path(conn, :show, t1_pool))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, t1_pool: t1_pool} do
      conn = put(conn, Routes.t1_pool_path(conn, :update, t1_pool), t1_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T1 pool"
    end
  end

  describe "delete t1_pool" do
    setup [:create_t1_pool]

    test "deletes chosen t1_pool", %{conn: conn, t1_pool: t1_pool} do
      conn = delete(conn, Routes.t1_pool_path(conn, :delete, t1_pool))
      assert redirected_to(conn) == Routes.t1_pool_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t1_pool_path(conn, :show, t1_pool))
      end
    end
  end

  defp create_t1_pool(_) do
    t1_pool = fixture(:t1_pool)
    {:ok, t1_pool: t1_pool}
  end
end
