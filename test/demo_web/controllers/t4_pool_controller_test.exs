defmodule DemoWeb.T4ControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T4s

  @create_attrs %{BSE: "some BSE", DB: "some DB", ENX: "some ENX", JPX: "some JPX", KRX: "some KRX", LSE: "some LSE", NASDAQ: "some NASDAQ", NSE: "some NSE", NYSE: "some NYSE", SEHK: "some SEHK", SIX: "some SIX", SSE: "some SSE", SZSE: "some SZSE", TSX: "some TSX"}
  @update_attrs %{BSE: "some updated BSE", DB: "some updated DB", ENX: "some updated ENX", JPX: "some updated JPX", KRX: "some updated KRX", LSE: "some updated LSE", NASDAQ: "some updated NASDAQ", NSE: "some updated NSE", NYSE: "some updated NYSE", SEHK: "some updated SEHK", SIX: "some updated SIX", SSE: "some updated SSE", SZSE: "some updated SZSE", TSX: "some updated TSX"}
  @invalid_attrs %{BSE: nil, DB: nil, ENX: nil, JPX: nil, KRX: nil, LSE: nil, NASDAQ: nil, NSE: nil, NYSE: nil, SEHK: nil, SIX: nil, SSE: nil, SZSE: nil, TSX: nil}

  def fixture(:t4) do
    {:ok, t4} = T4s.create_t4(@create_attrs)
    t4
  end

  describe "index" do
    test "lists all t4s", %{conn: conn} do
      conn = get(conn, Routes.t4_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T4 lists"
    end
  end

  describe "new t4" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t4_path(conn, :new))
      assert html_response(conn, 200) =~ "New T4 list"
    end
  end

  describe "create t4" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t4_path(conn, :create), t4: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t4_path(conn, :show, id)

      conn = get(conn, Routes.t4_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T4 list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t4_path(conn, :create), t4: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T4 list"
    end
  end

  describe "edit t4" do
    setup [:create_t4]

    test "renders form for editing chosen t4", %{conn: conn, t4: t4} do
      conn = get(conn, Routes.t4_path(conn, :edit, t4))
      assert html_response(conn, 200) =~ "Edit T4 list"
    end
  end

  describe "update t4" do
    setup [:create_t4]

    test "redirects when data is valid", %{conn: conn, t4: t4} do
      conn = put(conn, Routes.t4_path(conn, :update, t4), t4: @update_attrs)
      assert redirected_to(conn) == Routes.t4_path(conn, :show, t4)

      conn = get(conn, Routes.t4_path(conn, :show, t4))
      assert html_response(conn, 200) =~ "some updated BSE"
    end

    test "renders errors when data is invalid", %{conn: conn, t4: t4} do
      conn = put(conn, Routes.t4_path(conn, :update, t4), t4: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T4 list"
    end
  end

  describe "delete t4" do
    setup [:create_t4]

    test "deletes chosen t4", %{conn: conn, t4: t4} do
      conn = delete(conn, Routes.t4_path(conn, :delete, t4))
      assert redirected_to(conn) == Routes.t4_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t4_path(conn, :show, t4))
      end
    end
  end

  defp create_t4(_) do
    t4 = fixture(:t4)
    {:ok, t4: t4}
  end
end
