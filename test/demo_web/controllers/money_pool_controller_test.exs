defmodule DemoWeb.MoneyPoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.MoneyPools

  @create_attrs %{cad: "some cad", cny: "some cny", eur: "some eur", gbp: "some gbp", jpy: "some jpy", krw: "some krw", usd: "some usd"}
  @update_attrs %{cad: "some updated cad", cny: "some updated cny", eur: "some updated eur", gbp: "some updated gbp", jpy: "some updated jpy", krw: "some updated krw", usd: "some updated usd"}
  @invalid_attrs %{cad: nil, cny: nil, eur: nil, gbp: nil, jpy: nil, krw: nil, usd: nil}

  def fixture(:money_pool) do
    {:ok, money_pool} = MoneyPools.create_money_pool(@create_attrs)
    money_pool
  end

  describe "index" do
    test "lists all money_pools", %{conn: conn} do
      conn = get(conn, Routes.money_pool_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Money pools"
    end
  end

  describe "new money_pool" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.money_pool_path(conn, :new))
      assert html_response(conn, 200) =~ "New Money pool"
    end
  end

  describe "create money_pool" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.money_pool_path(conn, :create), money_pool: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.money_pool_path(conn, :show, id)

      conn = get(conn, Routes.money_pool_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Money pool"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.money_pool_path(conn, :create), money_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Money pool"
    end
  end

  describe "edit money_pool" do
    setup [:create_money_pool]

    test "renders form for editing chosen money_pool", %{conn: conn, money_pool: money_pool} do
      conn = get(conn, Routes.money_pool_path(conn, :edit, money_pool))
      assert html_response(conn, 200) =~ "Edit Money pool"
    end
  end

  describe "update money_pool" do
    setup [:create_money_pool]

    test "redirects when data is valid", %{conn: conn, money_pool: money_pool} do
      conn = put(conn, Routes.money_pool_path(conn, :update, money_pool), money_pool: @update_attrs)
      assert redirected_to(conn) == Routes.money_pool_path(conn, :show, money_pool)

      conn = get(conn, Routes.money_pool_path(conn, :show, money_pool))
      assert html_response(conn, 200) =~ "some updated cad"
    end

    test "renders errors when data is invalid", %{conn: conn, money_pool: money_pool} do
      conn = put(conn, Routes.money_pool_path(conn, :update, money_pool), money_pool: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Money pool"
    end
  end

  describe "delete money_pool" do
    setup [:create_money_pool]

    test "deletes chosen money_pool", %{conn: conn, money_pool: money_pool} do
      conn = delete(conn, Routes.money_pool_path(conn, :delete, money_pool))
      assert redirected_to(conn) == Routes.money_pool_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.money_pool_path(conn, :show, money_pool))
      end
    end
  end

  defp create_money_pool(_) do
    money_pool = fixture(:money_pool)
    {:ok, money_pool: money_pool}
  end
end
