defmodule DemoWeb.T1ControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T1s

  @create_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
  @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
  @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

  def fixture(:t1) do
    {:ok, t1} = T1s.create_t1(@create_attrs)
    t1
  end

  describe "index" do
    test "lists all t1s", %{conn: conn} do
      conn = get(conn, Routes.t1_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T1 lists"
    end
  end

  describe "new t1" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t1_path(conn, :new))
      assert html_response(conn, 200) =~ "New T1 list"
    end
  end

  describe "create t1" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t1_path(conn, :create), t1: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t1_path(conn, :show, id)

      conn = get(conn, Routes.t1_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T1 list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t1_path(conn, :create), t1: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T1 list"
    end
  end

  describe "edit t1" do
    setup [:create_t1]

    test "renders form for editing chosen t1", %{conn: conn, t1: t1} do
      conn = get(conn, Routes.t1_path(conn, :edit, t1))
      assert html_response(conn, 200) =~ "Edit T1 list"
    end
  end

  describe "update t1" do
    setup [:create_t1]

    test "redirects when data is valid", %{conn: conn, t1: t1} do
      conn = put(conn, Routes.t1_path(conn, :update, t1), t1: @update_attrs)
      assert redirected_to(conn) == Routes.t1_path(conn, :show, t1)

      conn = get(conn, Routes.t1_path(conn, :show, t1))
      assert html_response(conn, 200) =~ "some updated AUD"
    end

    test "renders errors when data is invalid", %{conn: conn, t1: t1} do
      conn = put(conn, Routes.t1_path(conn, :update, t1), t1: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T1 list"
    end
  end

  describe "delete t1" do
    setup [:create_t1]

    test "deletes chosen t1", %{conn: conn, t1: t1} do
      conn = delete(conn, Routes.t1_path(conn, :delete, t1))
      assert redirected_to(conn) == Routes.t1_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t1_path(conn, :show, t1))
      end
    end
  end

  defp create_t1(_) do
    t1 = fixture(:t1)
    {:ok, t1: t1}
  end
end
