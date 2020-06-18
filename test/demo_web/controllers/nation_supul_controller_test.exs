defmodule DemoWeb.NationSupulControllerTest do
  use DemoWeb.ConnCase

  alias Demo.NationSupuls

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:nation_supul) do
    {:ok, nation_supul} = NationSupuls.create_nation_supul(@create_attrs)
    nation_supul
  end

  describe "index" do
    test "lists all nation_supuls", %{conn: conn} do
      conn = get(conn, Routes.nation_supul_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Nation supuls"
    end
  end

  describe "new nation_supul" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.nation_supul_path(conn, :new))
      assert html_response(conn, 200) =~ "New Nation supul"
    end
  end

  describe "create nation_supul" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.nation_supul_path(conn, :create), nation_supul: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.nation_supul_path(conn, :show, id)

      conn = get(conn, Routes.nation_supul_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Nation supul"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.nation_supul_path(conn, :create), nation_supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Nation supul"
    end
  end

  describe "edit nation_supul" do
    setup [:create_nation_supul]

    test "renders form for editing chosen nation_supul", %{conn: conn, nation_supul: nation_supul} do
      conn = get(conn, Routes.nation_supul_path(conn, :edit, nation_supul))
      assert html_response(conn, 200) =~ "Edit Nation supul"
    end
  end

  describe "update nation_supul" do
    setup [:create_nation_supul]

    test "redirects when data is valid", %{conn: conn, nation_supul: nation_supul} do
      conn = put(conn, Routes.nation_supul_path(conn, :update, nation_supul), nation_supul: @update_attrs)
      assert redirected_to(conn) == Routes.nation_supul_path(conn, :show, nation_supul)

      conn = get(conn, Routes.nation_supul_path(conn, :show, nation_supul))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, nation_supul: nation_supul} do
      conn = put(conn, Routes.nation_supul_path(conn, :update, nation_supul), nation_supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Nation supul"
    end
  end

  describe "delete nation_supul" do
    setup [:create_nation_supul]

    test "deletes chosen nation_supul", %{conn: conn, nation_supul: nation_supul} do
      conn = delete(conn, Routes.nation_supul_path(conn, :delete, nation_supul))
      assert redirected_to(conn) == Routes.nation_supul_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.nation_supul_path(conn, :show, nation_supul))
      end
    end
  end

  defp create_nation_supul(_) do
    nation_supul = fixture(:nation_supul)
    {:ok, nation_supul: nation_supul}
  end
end
