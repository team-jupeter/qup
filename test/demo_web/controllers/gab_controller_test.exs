defmodule DemoWeb.GABControllerTest do
  use DemoWeb.ConnCase

  alias Demo.GABs

  @create_attrs %{nationality: "some nationality"}
  @update_attrs %{nationality: "some updated nationality"}
  @invalid_attrs %{nationality: nil}

  def fixture(:gab) do
    {:ok, gab} = GABs.create_gab(@create_attrs)
    gab
  end

  describe "index" do
    test "lists all gabs", %{conn: conn} do
      conn = get(conn, Routes.gab_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Gabs"
    end
  end

  describe "new gab" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.gab_path(conn, :new))
      assert html_response(conn, 200) =~ "New Gab"
    end
  end

  describe "create gab" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gab_path(conn, :create), gab: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.gab_path(conn, :show, id)

      conn = get(conn, Routes.gab_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Gab"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gab_path(conn, :create), gab: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gab"
    end
  end

  describe "edit gab" do
    setup [:create_gab]

    test "renders form for editing chosen gab", %{conn: conn, gab: gab} do
      conn = get(conn, Routes.gab_path(conn, :edit, gab))
      assert html_response(conn, 200) =~ "Edit Gab"
    end
  end

  describe "update gab" do
    setup [:create_gab]

    test "redirects when data is valid", %{conn: conn, gab: gab} do
      conn = put(conn, Routes.gab_path(conn, :update, gab), gab: @update_attrs)
      assert redirected_to(conn) == Routes.gab_path(conn, :show, gab)

      conn = get(conn, Routes.gab_path(conn, :show, gab))
      assert html_response(conn, 200) =~ "some updated nationality"
    end

    test "renders errors when data is invalid", %{conn: conn, gab: gab} do
      conn = put(conn, Routes.gab_path(conn, :update, gab), gab: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gab"
    end
  end

  describe "delete gab" do
    setup [:create_gab]

    test "deletes chosen gab", %{conn: conn, gab: gab} do
      conn = delete(conn, Routes.gab_path(conn, :delete, gab))
      assert redirected_to(conn) == Routes.gab_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.gab_path(conn, :show, gab))
      end
    end
  end

  defp create_gab(_) do
    gab = fixture(:gab)
    {:ok, gab: gab}
  end
end
