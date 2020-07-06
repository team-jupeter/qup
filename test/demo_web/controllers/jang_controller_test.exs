defmodule DemoWeb.JangControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Jangs

  @create_attrs %{cart: "some cart"}
  @update_attrs %{cart: "some updated cart"}
  @invalid_attrs %{cart: nil}

  def fixture(:jang) do
    {:ok, jang} = Jangs.create_jang(@create_attrs)
    jang
  end

  describe "index" do
    test "lists all jangs", %{conn: conn} do
      conn = get(conn, Routes.jang_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Jangs"
    end
  end

  describe "new jang" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.jang_path(conn, :new))
      assert html_response(conn, 200) =~ "New Jang"
    end
  end

  describe "create jang" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.jang_path(conn, :create), jang: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.jang_path(conn, :show, id)

      conn = get(conn, Routes.jang_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Jang"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.jang_path(conn, :create), jang: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Jang"
    end
  end

  describe "edit jang" do
    setup [:create_jang]

    test "renders form for editing chosen jang", %{conn: conn, jang: jang} do
      conn = get(conn, Routes.jang_path(conn, :edit, jang))
      assert html_response(conn, 200) =~ "Edit Jang"
    end
  end

  describe "update jang" do
    setup [:create_jang]

    test "redirects when data is valid", %{conn: conn, jang: jang} do
      conn = put(conn, Routes.jang_path(conn, :update, jang), jang: @update_attrs)
      assert redirected_to(conn) == Routes.jang_path(conn, :show, jang)

      conn = get(conn, Routes.jang_path(conn, :show, jang))
      assert html_response(conn, 200) =~ "some updated cart"
    end

    test "renders errors when data is invalid", %{conn: conn, jang: jang} do
      conn = put(conn, Routes.jang_path(conn, :update, jang), jang: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Jang"
    end
  end

  describe "delete jang" do
    setup [:create_jang]

    test "deletes chosen jang", %{conn: conn, jang: jang} do
      conn = delete(conn, Routes.jang_path(conn, :delete, jang))
      assert redirected_to(conn) == Routes.jang_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.jang_path(conn, :show, jang))
      end
    end
  end

  defp create_jang(_) do
    jang = fixture(:jang)
    {:ok, jang: jang}
  end
end
