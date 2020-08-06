defmodule DemoWeb.T3ControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T3s

  @create_attrs %{book_price: "some book_price", current_owner: "some current_owner"}
  @update_attrs %{book_price: "some updated book_price", current_owner: "some updated current_owner"}
  @invalid_attrs %{book_price: nil, current_owner: nil}

  def fixture(:t3) do
    {:ok, t3} = T3s.create_t3(@create_attrs)
    t3
  end

  describe "index" do
    test "lists all t3s", %{conn: conn} do
      conn = get(conn, Routes.t3_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T3s"
    end
  end

  describe "new t3" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t3_path(conn, :new))
      assert html_response(conn, 200) =~ "New T3"
    end
  end

  describe "create t3" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t3_path(conn, :create), t3: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t3_path(conn, :show, id)

      conn = get(conn, Routes.t3_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T3"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t3_path(conn, :create), t3: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T3"
    end
  end

  describe "edit t3" do
    setup [:create_t3]

    test "renders form for editing chosen t3", %{conn: conn, t3: t3} do
      conn = get(conn, Routes.t3_path(conn, :edit, t3))
      assert html_response(conn, 200) =~ "Edit T3"
    end
  end

  describe "update t3" do
    setup [:create_t3]

    test "redirects when data is valid", %{conn: conn, t3: t3} do
      conn = put(conn, Routes.t3_path(conn, :update, t3), t3: @update_attrs)
      assert redirected_to(conn) == Routes.t3_path(conn, :show, t3)

      conn = get(conn, Routes.t3_path(conn, :show, t3))
      assert html_response(conn, 200) =~ "some updated book_price"
    end

    test "renders errors when data is invalid", %{conn: conn, t3: t3} do
      conn = put(conn, Routes.t3_path(conn, :update, t3), t3: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T3"
    end
  end

  describe "delete t3" do
    setup [:create_t3]

    test "deletes chosen t3", %{conn: conn, t3: t3} do
      conn = delete(conn, Routes.t3_path(conn, :delete, t3))
      assert redirected_to(conn) == Routes.t3_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t3_path(conn, :show, t3))
      end
    end
  end

  defp create_t3(_) do
    t3 = fixture(:t3)
    {:ok, t3: t3}
  end
end
