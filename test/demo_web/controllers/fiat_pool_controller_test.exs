defmodule DemoWeb.FiatPoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.FiatPools

  @create_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
  @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
  @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

  def fixture(:fiat_pool) do
    {:ok, fiat_pool} = FiatPools.create_fiat_pool(@create_attrs)
    fiat_pool
  end

  describe "index" do
    test "lists all fiat_pools", %{conn: conn} do
      conn = get(conn, Routes.fiat_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Fiat pools"
    end
  end

  describe "new fiat_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.fiat_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New Fiat pool"
    end
  end

  describe "create fiat_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fiat_pool_path(conn, :create), fiat_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.fiat_pool_path(conn, :show, id)

      conn = get(conn, Routes.fiat_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Fiat pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fiat_pool_path(conn, :create), fiat_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Fiat pool"
    end
  end

  describe "edit fiat_pool" do
    setup [:create_fiat_pool]

    test "renders form for editing chosen fiat_pool", %{conn: conn, fiat_pool: fiat_pool} do
      conn = get(conn, Routes.fiat_pool_path(conn, :edit, fiat_pool))
      assert html_response(conn, 200) =~ "Edit Fiat pool"
    end
  end

  describe "update fiat_pool" do
    setup [:create_fiat_pool]

    test "redirects when data is valid", %{conn: conn, fiat_pool: fiat_pool} do
      conn = put(conn, Routes.fiat_pool_path(conn, :update, fiat_pool), fiat_pool: @update_attrs)
      assert redirected_to(conn) == Routes.fiat_pool_path(conn, :show, fiat_pool)

      conn = get(conn, Routes.fiat_pool_path(conn, :show, fiat_pool))
      assert html_response(conn, 200) =~ "some updated AUD"
    end

    test "renders errors when data is invalid", %{conn: conn, fiat_pool: fiat_pool} do
      conn = put(conn, Routes.fiat_pool_path(conn, :update, fiat_pool), fiat_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Fiat pool"
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
