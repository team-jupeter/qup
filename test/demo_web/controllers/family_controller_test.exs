defmodule DemoWeb.FamilyControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Families

  @create_attrs %{family_code: "some family_code"}
  @update_attrs %{family_code: "some updated family_code"}
  @invalid_attrs %{family_code: nil}

  def fixture(:family) do
    {:ok, family} = Families.create_family(@create_attrs)
    family
  end

  describe "index" do
    test "lists all families", %{conn: conn} do
      conn = get(conn, Routes.family_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Families"
    end
  end

  describe "new family" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.family_path(conn, :new))
      assert html_response(conn, 200) =~ "New Family"
    end
  end

  describe "create family" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.family_path(conn, :create), family: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.family_path(conn, :show, id)

      conn = get(conn, Routes.family_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Family"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.family_path(conn, :create), family: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Family"
    end
  end

  describe "edit family" do
    setup [:create_family]

    test "renders form for editing chosen family", %{conn: conn, family: family} do
      conn = get(conn, Routes.family_path(conn, :edit, family))
      assert html_response(conn, 200) =~ "Edit Family"
    end
  end

  describe "update family" do
    setup [:create_family]

    test "redirects when data is valid", %{conn: conn, family: family} do
      conn = put(conn, Routes.family_path(conn, :update, family), family: @update_attrs)
      assert redirected_to(conn) == Routes.family_path(conn, :show, family)

      conn = get(conn, Routes.family_path(conn, :show, family))
      assert html_response(conn, 200) =~ "some updated family_code"
    end

    test "renders errors when data is invalid", %{conn: conn, family: family} do
      conn = put(conn, Routes.family_path(conn, :update, family), family: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Family"
    end
  end

  describe "delete family" do
    setup [:create_family]

    test "deletes chosen family", %{conn: conn, family: family} do
      conn = delete(conn, Routes.family_path(conn, :delete, family))
      assert redirected_to(conn) == Routes.family_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.family_path(conn, :show, family))
      end
    end
  end

  defp create_family(_) do
    family = fixture(:family)
    {:ok, family: family}
  end
end
