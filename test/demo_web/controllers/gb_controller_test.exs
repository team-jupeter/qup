defmodule DemoWeb.GBControllerTest do
  use DemoWeb.ConnCase

  alias Demo.GBs

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:gb) do
    {:ok, gb} = GBs.create_gb(@create_attrs)
    gb
  end

  describe "index" do
    test "lists all gbs", %{conn: conn} do
      conn = get(conn, Routes.gb_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Gbs"
    end
  end

  describe "new gb" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.gb_path(conn, :new))
      assert html_response(conn, 200) =~ "New Gb"
    end
  end

  describe "create gb" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gb_path(conn, :create), gb: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.gb_path(conn, :show, id)

      conn = get(conn, Routes.gb_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Gb"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gb_path(conn, :create), gb: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gb"
    end
  end

  describe "edit gb" do
    setup [:create_gb]

    test "renders form for editing chosen gb", %{conn: conn, gb: gb} do
      conn = get(conn, Routes.gb_path(conn, :edit, gb))
      assert html_response(conn, 200) =~ "Edit Gb"
    end
  end

  describe "update gb" do
    setup [:create_gb]

    test "redirects when data is valid", %{conn: conn, gb: gb} do
      conn = put(conn, Routes.gb_path(conn, :update, gb), gb: @update_attrs)
      assert redirected_to(conn) == Routes.gb_path(conn, :show, gb)

      conn = get(conn, Routes.gb_path(conn, :show, gb))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, gb: gb} do
      conn = put(conn, Routes.gb_path(conn, :update, gb), gb: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gb"
    end
  end

  describe "delete gb" do
    setup [:create_gb]

    test "deletes chosen gb", %{conn: conn, gb: gb} do
      conn = delete(conn, Routes.gb_path(conn, :delete, gb))
      assert redirected_to(conn) == Routes.gb_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.gb_path(conn, :show, gb))
      end
    end
  end

  defp create_gb(_) do
    gb = fixture(:gb)
    {:ok, gb: gb}
  end
end
