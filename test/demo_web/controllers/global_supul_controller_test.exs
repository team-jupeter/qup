defmodule DemoWeb.GlobalSupulControllerTest do
  use DemoWeb.ConnCase

  alias Demo.GlobalSupuls

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:global_supul) do
    {:ok, global_supul} = GlobalSupuls.create_global_supul(@create_attrs)
    global_supul
  end

  describe "index" do
    test "lists all global_supuls", %{conn: conn} do
      conn = get(conn, Routes.global_supul_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Global supuls"
    end
  end

  describe "new global_supul" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.global_supul_path(conn, :new))
      assert html_response(conn, 200) =~ "New Global supul"
    end
  end

  describe "create global_supul" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.global_supul_path(conn, :create), global_supul: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.global_supul_path(conn, :show, id)

      conn = get(conn, Routes.global_supul_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Global supul"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.global_supul_path(conn, :create), global_supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Global supul"
    end
  end

  describe "edit global_supul" do
    setup [:create_global_supul]

    test "renders form for editing chosen global_supul", %{conn: conn, global_supul: global_supul} do
      conn = get(conn, Routes.global_supul_path(conn, :edit, global_supul))
      assert html_response(conn, 200) =~ "Edit Global supul"
    end
  end

  describe "update global_supul" do
    setup [:create_global_supul]

    test "redirects when data is valid", %{conn: conn, global_supul: global_supul} do
      conn = put(conn, Routes.global_supul_path(conn, :update, global_supul), global_supul: @update_attrs)
      assert redirected_to(conn) == Routes.global_supul_path(conn, :show, global_supul)

      conn = get(conn, Routes.global_supul_path(conn, :show, global_supul))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, global_supul: global_supul} do
      conn = put(conn, Routes.global_supul_path(conn, :update, global_supul), global_supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Global supul"
    end
  end

  describe "delete global_supul" do
    setup [:create_global_supul]

    test "deletes chosen global_supul", %{conn: conn, global_supul: global_supul} do
      conn = delete(conn, Routes.global_supul_path(conn, :delete, global_supul))
      assert redirected_to(conn) == Routes.global_supul_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.global_supul_path(conn, :show, global_supul))
      end
    end
  end

  defp create_global_supul(_) do
    global_supul = fixture(:global_supul)
    {:ok, global_supul: global_supul}
  end
end
