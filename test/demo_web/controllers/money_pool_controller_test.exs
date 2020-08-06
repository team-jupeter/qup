defmodule DemoWeb.FiatPoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.FiatPools

  @create_attrs %{cad: "some cad", cny: "some cny", eur: "some eur", gbp: "some gbp", jpy: "some jpy", krw: "some krw", usd: "some usd"}
  @update_attrs %{cad: "some updated cad", cny: "some updated cny", eur: "some updated eur", gbp: "some updated gbp", jpy: "some updated jpy", krw: "some updated krw", usd: "some updated usd"}
  @invalid_attrs %{cad: nil, cny: nil, eur: nil, gbp: nil, jpy: nil, krw: nil, usd: nil}

  def fixture(:fiat_pool) do
    {:ok, fiat_pool} = FiatPools.create_fiat_pool(@create_attrs)
    fiat_pool
  end

  describe "index" do
    test "lists all fiat_pools", %{conn: conn} do
      conn = get(conn, Routes.fiat_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Money pools"
    end
  end

  describe "new fiat_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fiat_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New Money pool"
    end
  end

  describe "create fiat_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fiat_pool_path(conn, :create), fiat_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fiat_pool_path(conn, :show, id)

      conn = get(conn, Routes.fiat_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Money pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fiat_pool_path(conn, :create), fiat_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Money pool"
    end
  end

  describe "edit fiat_pool" do
    setup [:create_fiat_pool]

    test "renders form for editing chosen fiat_pool", %{conn: conn, fiat_pool: fiat_pool} do
      conn = get(conn, Routes.fiat_pool_path(conn, :edit, fiat_pool))
      assert html_response(conn, 200) =~ "Edit Money pool"
    end
  end

  describe "update fiat_pool" do
    setup [:create_fiat_pool]

    test "redirects when data is valid", %{conn: conn, fiat_pool: fiat_pool} do
      conn = put(conn, Routes.fiat_pool_path(conn, :update, fiat_pool), fiat_pool: @update_attrs)
      assert redirected_to(conn) == Routes.fiat_pool_path(conn, :show, fiat_pool)

      conn = get(conn, Routes.fiat_pool_path(conn, :show, fiat_pool))
      assert html_response(conn, 200) =~ "some updated cad"
    end

    test "renders errors when data is invalid", %{conn: conn, fiat_pool: fiat_pool} do
      conn = put(conn, Routes.fiat_pool_path(conn, :update, fiat_pool), fiat_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Money pool"
    end
  end

  describe "delete fiat_pool" do
    setup [:create_fiat_pool]

    test "deletes chosen fiat_pool", %{conn: conn, fiat_pool: fiat_pool} do
      conn = delete(conn, Routes.fiat_pool_path(conn, :delete, fiat_pool))
      assert redirected_to(conn) == Routes.fiat_pool_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.fiat_pool_path(conn, :show, fiat_pool))
      end
    end
  end

  defp create_fiat_pool(_) do
    fiat_pool = fixture(:fiat_pool)
    {:ok, fiat_pool: fiat_pool}
  end
end
