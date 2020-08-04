defmodule DemoWeb.TelControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Tels

  @create_attrs %{number: 42}
  @update_attrs %{number: 43}
  @invalid_attrs %{number: nil}

  def fixture(:tel) do
    {:ok, tel} = Tels.create_tel(@create_attrs)
    tel
  end

  describe "index" do
    test "lists all tels", %{conn: conn} do
      conn = get(conn, Routes.tel_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tels"
    end
  end

  describe "new tel" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tel_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tel"
    end
  end

  describe "create tel" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tel_path(conn, :create), tel: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tel_path(conn, :show, id)

      conn = get(conn, Routes.tel_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tel"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tel_path(conn, :create), tel: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tel"
    end
  end

  describe "edit tel" do
    setup [:create_tel]

    test "renders form for editing chosen tel", %{conn: conn, tel: tel} do
      conn = get(conn, Routes.tel_path(conn, :edit, tel))
      assert html_response(conn, 200) =~ "Edit Tel"
    end
  end

  describe "update tel" do
    setup [:create_tel]

    test "redirects when data is valid", %{conn: conn, tel: tel} do
      conn = put(conn, Routes.tel_path(conn, :update, tel), tel: @update_attrs)
      assert redirected_to(conn) == Routes.tel_path(conn, :show, tel)

      conn = get(conn, Routes.tel_path(conn, :show, tel))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, tel: tel} do
      conn = put(conn, Routes.tel_path(conn, :update, tel), tel: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tel"
    end
  end

  describe "delete tel" do
    setup [:create_tel]

    test "deletes chosen tel", %{conn: conn, tel: tel} do
      conn = delete(conn, Routes.tel_path(conn, :delete, tel))
      assert redirected_to(conn) == Routes.tel_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tel_path(conn, :show, tel))
      end
    end
  end

  defp create_tel(_) do
    tel = fixture(:tel)
    {:ok, tel: tel}
  end
end
