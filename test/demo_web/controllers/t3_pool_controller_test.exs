defmodule DemoWeb.T3PoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T3Pools

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:t3_pool) do
    {:ok, t3_pool} = T3Pools.create_t3_pool(@create_attrs)
    t3_pool
  end

  describe "index" do
    test "lists all t3_pools", %{conn: conn} do
      conn = get(conn, Routes.t3_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T3 pools"
    end
  end

  describe "new t3_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t3_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New T3 pool"
    end
  end

  describe "create t3_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t3_pool_path(conn, :create), t3_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t3_pool_path(conn, :show, id)

      conn = get(conn, Routes.t3_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T3 pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t3_pool_path(conn, :create), t3_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T3 pool"
    end
  end

  describe "edit t3_pool" do
    setup [:create_t3_pool]

    test "renders form for editing chosen t3_pool", %{conn: conn, t3_pool: t3_pool} do
      conn = get(conn, Routes.t3_pool_path(conn, :edit, t3_pool))
      assert html_response(conn, 200) =~ "Edit T3 pool"
    end
  end

  describe "update t3_pool" do
    setup [:create_t3_pool]

    test "redirects when data is valid", %{conn: conn, t3_pool: t3_pool} do
      conn = put(conn, Routes.t3_pool_path(conn, :update, t3_pool), t3_pool: @update_attrs)
      assert redirected_to(conn) == Routes.t3_pool_path(conn, :show, t3_pool)

      conn = get(conn, Routes.t3_pool_path(conn, :show, t3_pool))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, t3_pool: t3_pool} do
      conn = put(conn, Routes.t3_pool_path(conn, :update, t3_pool), t3_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T3 pool"
    end
  end

  describe "delete t3_pool" do
    setup [:create_t3_pool]

    test "deletes chosen t3_pool", %{conn: conn, t3_pool: t3_pool} do
      conn = delete(conn, Routes.t3_pool_path(conn, :delete, t3_pool))
      assert redirected_to(conn) == Routes.t3_pool_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t3_pool_path(conn, :show, t3_pool))
      end
    end
  end

  defp create_t3_pool(_) do
    t3_pool = fixture(:t3_pool)
    {:ok, t3_pool: t3_pool}
  end
end
