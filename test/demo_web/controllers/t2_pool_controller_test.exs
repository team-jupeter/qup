defmodule DemoWeb.T2ListControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T2Lists

  @create_attrs %{AUD: "some AUD", CAD: "some CAD", CHF: "some CHF", CNY: "some CNY", EUR: "some EUR", GBP: "some GBP", HKD: "some HKD", JPY: "some JPY", KRW: "some KRW", MXN: "some MXN", NOK: "some NOK", NZD: "some NZD", SEK: "some SEK", SGD: "some SGD", USD: "some USD"}
  @update_attrs %{AUD: "some updated AUD", CAD: "some updated CAD", CHF: "some updated CHF", CNY: "some updated CNY", EUR: "some updated EUR", GBP: "some updated GBP", HKD: "some updated HKD", JPY: "some updated JPY", KRW: "some updated KRW", MXN: "some updated MXN", NOK: "some updated NOK", NZD: "some updated NZD", SEK: "some updated SEK", SGD: "some updated SGD", USD: "some updated USD"}
  @invalid_attrs %{AUD: nil, CAD: nil, CHF: nil, CNY: nil, EUR: nil, GBP: nil, HKD: nil, JPY: nil, KRW: nil, MXN: nil, NOK: nil, NZD: nil, SEK: nil, SGD: nil, USD: nil}

  def fixture(:t2_list) do
    {:ok, t2_list} = T2Lists.create_t2_list(@create_attrs)
    t2_list
  end

  describe "index" do
    test "lists all t2_lists", %{conn: conn} do
      conn = get(conn, Routes.t2_list_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T2 lists"
    end
  end

  describe "new t2_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t2_list_path(conn, :new))
      assert html_response(conn, 200) =~ "New T2 list"
    end
  end

  describe "create t2_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t2_list_path(conn, :create), t2_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t2_list_path(conn, :show, id)

      conn = get(conn, Routes.t2_list_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T2 list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t2_list_path(conn, :create), t2_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T2 list"
    end
  end

  describe "edit t2_list" do
    setup [:create_t2_list]

    test "renders form for editing chosen t2_list", %{conn: conn, t2_list: t2_list} do
      conn = get(conn, Routes.t2_list_path(conn, :edit, t2_list))
      assert html_response(conn, 200) =~ "Edit T2 list"
    end
  end

  describe "update t2_list" do
    setup [:create_t2_list]

    test "redirects when data is valid", %{conn: conn, t2_list: t2_list} do
      conn = put(conn, Routes.t2_list_path(conn, :update, t2_list), t2_list: @update_attrs)
      assert redirected_to(conn) == Routes.t2_list_path(conn, :show, t2_list)

      conn = get(conn, Routes.t2_list_path(conn, :show, t2_list))
      assert html_response(conn, 200) =~ "some updated AUD"
    end

    test "renders errors when data is invalid", %{conn: conn, t2_list: t2_list} do
      conn = put(conn, Routes.t2_list_path(conn, :update, t2_list), t2_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T2 list"
    end
  end

  describe "delete t2_list" do
    setup [:create_t2_list]

    test "deletes chosen t2_list", %{conn: conn, t2_list: t2_list} do
      conn = delete(conn, Routes.t2_list_path(conn, :delete, t2_list))
      assert redirected_to(conn) == Routes.t2_list_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t2_list_path(conn, :show, t2_list))
      end
    end
  end

  defp create_t2_list(_) do
    t2_list = fixture(:t2_list)
    {:ok, t2_list: t2_list}
  end
end
