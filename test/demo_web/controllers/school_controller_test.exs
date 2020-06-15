defmodule DemoWeb.SchoolControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Campus

  @create_attrs %{description: "some description", mentors: "some mentors", title: "some title"}
  @update_attrs %{description: "some updated description", mentors: "some updated mentors", title: "some updated title"}
  @invalid_attrs %{description: nil, mentors: nil, title: nil}

  def fixture(:school) do
    {:ok, school} = Campus.create_school(@create_attrs)
    school
  end

  describe "index" do
    test "lists all schools", %{conn: conn} do
      conn = get(conn, Routes.school_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Schools"
    end
  end

  describe "new school" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.school_path(conn, :new))
      assert html_response(conn, 200) =~ "New School"
    end
  end

  describe "create school" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.school_path(conn, :create), school: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.school_path(conn, :show, id)

      conn = get(conn, Routes.school_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show School"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.school_path(conn, :create), school: @invalid_attrs)
      assert html_response(conn, 200) =~ "New School"
    end
  end

  describe "edit school" do
    setup [:create_school]

    test "renders form for editing chosen school", %{conn: conn, school: school} do
      conn = get(conn, Routes.school_path(conn, :edit, school))
      assert html_response(conn, 200) =~ "Edit School"
    end
  end

  describe "update school" do
    setup [:create_school]

    test "redirects when data is valid", %{conn: conn, school: school} do
      conn = put(conn, Routes.school_path(conn, :update, school), school: @update_attrs)
      assert redirected_to(conn) == Routes.school_path(conn, :show, school)

      conn = get(conn, Routes.school_path(conn, :show, school))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, school: school} do
      conn = put(conn, Routes.school_path(conn, :update, school), school: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit School"
    end
  end

  describe "delete school" do
    setup [:create_school]

    test "deletes chosen school", %{conn: conn, school: school} do
      conn = delete(conn, Routes.school_path(conn, :delete, school))
      assert redirected_to(conn) == Routes.school_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.school_path(conn, :show, school))
      end
    end
  end

  defp create_school(_) do
    school = fixture(:school)
    {:ok, school: school}
  end
end
