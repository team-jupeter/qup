defmodule DemoWeb.SupulControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Supuls

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  def fixture(:supul) do
    {:ok, supul} = Supuls.create_supul(@create_attrs)
    supul
  end

  describe "index" do
    test "lists all supuls", %{conn: conn} do
      conn = get(conn, Routes.supul_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Supuls"
    end
  end

  describe "new supul" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.supul_path(conn, :new))
      assert html_response(conn, 200) =~ "New Supul"
    end
  end

  describe "create supul" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.supul_path(conn, :create), supul: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.supul_path(conn, :show, id)

      conn = get(conn, Routes.supul_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Supul"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.supul_path(conn, :create), supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Supul"
    end
  end

  describe "edit supul" do
    setup [:create_supul]

    test "renders form for editing chosen supul", %{conn: conn, supul: supul} do
      conn = get(conn, Routes.supul_path(conn, :edit, supul))
      assert html_response(conn, 200) =~ "Edit Supul"
    end
  end

  describe "update supul" do
    setup [:create_supul]

    test "redirects when data is valid", %{conn: conn, supul: supul} do
      conn = put(conn, Routes.supul_path(conn, :update, supul), supul: @update_attrs)
      assert redirected_to(conn) == Routes.supul_path(conn, :show, supul)

      conn = get(conn, Routes.supul_path(conn, :show, supul))
      assert html_response(conn, 200) =~ "some updated type"
    end

    test "renders errors when data is invalid", %{conn: conn, supul: supul} do
      conn = put(conn, Routes.supul_path(conn, :update, supul), supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Supul"
    end
  end

  describe "delete supul" do
    setup [:create_supul]

    test "deletes chosen supul", %{conn: conn, supul: supul} do
      conn = delete(conn, Routes.supul_path(conn, :delete, supul))
      assert redirected_to(conn) == Routes.supul_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.supul_path(conn, :show, supul))
      end
    end
  end

  defp create_supul(_) do
    supul = fixture(:supul)
    {:ok, supul: supul}
  end
end
