defmodule DemoWeb.T1ListControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T1Lists

  @create_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
  @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
  @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

  def fixture(:t1_list) do
    {:ok, t1_list} = T1Lists.create_t1_list(@create_attrs)
    t1_list
  end

  describe "index" do
    test "lists all t1_lists", %{conn: conn} do
      conn = get(conn, Routes.t1_list_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T1 lists"
    end
  end

  describe "new t1_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t1_list_path(conn, :new))
      assert html_response(conn, 200) =~ "New T1 list"
    end
  end

  describe "create t1_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t1_list_path(conn, :create), t1_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t1_list_path(conn, :show, id)

      conn = get(conn, Routes.t1_list_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T1 list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t1_list_path(conn, :create), t1_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T1 list"
    end
  end

  describe "edit t1_list" do
    setup [:create_t1_list]

    test "renders form for editing chosen t1_list", %{conn: conn, t1_list: t1_list} do
      conn = get(conn, Routes.t1_list_path(conn, :edit, t1_list))
      assert html_response(conn, 200) =~ "Edit T1 list"
    end
  end

  describe "update t1_list" do
    setup [:create_t1_list]

    test "redirects when data is valid", %{conn: conn, t1_list: t1_list} do
      conn = put(conn, Routes.t1_list_path(conn, :update, t1_list), t1_list: @update_attrs)
      assert redirected_to(conn) == Routes.t1_list_path(conn, :show, t1_list)

      conn = get(conn, Routes.t1_list_path(conn, :show, t1_list))
      assert html_response(conn, 200) =~ "some updated AUD"
    end

    test "renders errors when data is invalid", %{conn: conn, t1_list: t1_list} do
      conn = put(conn, Routes.t1_list_path(conn, :update, t1_list), t1_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T1 list"
    end
  end

  describe "delete t1_list" do
    setup [:create_t1_list]

    test "deletes chosen t1_list", %{conn: conn, t1_list: t1_list} do
      conn = delete(conn, Routes.t1_list_path(conn, :delete, t1_list))
      assert redirected_to(conn) == Routes.t1_list_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t1_list_path(conn, :show, t1_list))
      end
    end
  end

  defp create_t1_list(_) do
    t1_list = fixture(:t1_list)
    {:ok, t1_list: t1_list}
  end
end
