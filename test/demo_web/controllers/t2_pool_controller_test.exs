defmodule DemoWeb.T2ControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T2s

  @create_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
  @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
  @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

  def fixture(:t2) do
    {:ok, t2} = T2s.create_t2(@create_attrs)
    t2
  end

  describe "index" do
    test "lists all t2s", %{conn: conn} do
      conn = get(conn, Routes.t2_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T2 lists"
    end
  end

  describe "new t2" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t2_path(conn, :new))
      assert html_response(conn, 200) =~ "New T2 list"
    end
  end

  describe "create t2" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t2_path(conn, :create), t2: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t2_path(conn, :show, id)

      conn = get(conn, Routes.t2_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T2 list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t2_path(conn, :create), t2: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T2 list"
    end
  end

  describe "edit t2" do
    setup [:create_t2]

    test "renders form for editing chosen t2", %{conn: conn, t2: t2} do
      conn = get(conn, Routes.t2_path(conn, :edit, t2))
      assert html_response(conn, 200) =~ "Edit T2 list"
    end
  end

  describe "update t2" do
    setup [:create_t2]

    test "redirects when data is valid", %{conn: conn, t2: t2} do
      conn = put(conn, Routes.t2_path(conn, :update, t2), t2: @update_attrs)
      assert redirected_to(conn) == Routes.t2_path(conn, :show, t2)

      conn = get(conn, Routes.t2_path(conn, :show, t2))
      assert html_response(conn, 200) =~ "some updated AUD"
    end

    test "renders errors when data is invalid", %{conn: conn, t2: t2} do
      conn = put(conn, Routes.t2_path(conn, :update, t2), t2: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T2 list"
    end
  end

  describe "delete t2" do
    setup [:create_t2]

    test "deletes chosen t2", %{conn: conn, t2: t2} do
      conn = delete(conn, Routes.t2_path(conn, :delete, t2))
      assert redirected_to(conn) == Routes.t2_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t2_path(conn, :show, t2))
      end
    end
  end

  defp create_t2(_) do
    t2 = fixture(:t2)
    {:ok, t2: t2}
  end
end
