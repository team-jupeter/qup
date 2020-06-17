defmodule DemoWeb.NationControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Nations

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:nation) do
    {:ok, nation} = Nations.create_nation(@create_attrs)
    nation
  end

  describe "index" do
    test "lists all nations", %{conn: conn} do
      conn = get(conn, Routes.nation_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Nations"
    end
  end

  describe "new nation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.nation_path(conn, :new))
      assert html_response(conn, 200) =~ "New Nation"
    end
  end

  describe "create nation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.nation_path(conn, :create), nation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.nation_path(conn, :show, id)

      conn = get(conn, Routes.nation_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Nation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.nation_path(conn, :create), nation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Nation"
    end
  end

  describe "edit nation" do
    setup [:create_nation]

    test "renders form for editing chosen nation", %{conn: conn, nation: nation} do
      conn = get(conn, Routes.nation_path(conn, :edit, nation))
      assert html_response(conn, 200) =~ "Edit Nation"
    end
  end

  describe "update nation" do
    setup [:create_nation]

    test "redirects when data is valid", %{conn: conn, nation: nation} do
      conn = put(conn, Routes.nation_path(conn, :update, nation), nation: @update_attrs)
      assert redirected_to(conn) == Routes.nation_path(conn, :show, nation)

      conn = get(conn, Routes.nation_path(conn, :show, nation))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, nation: nation} do
      conn = put(conn, Routes.nation_path(conn, :update, nation), nation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Nation"
    end
  end

  describe "delete nation" do
    setup [:create_nation]

    test "deletes chosen nation", %{conn: conn, nation: nation} do
      conn = delete(conn, Routes.nation_path(conn, :delete, nation))
      assert redirected_to(conn) == Routes.nation_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.nation_path(conn, :show, nation))
      end
    end
  end

  defp create_nation(_) do
    nation = fixture(:nation)
    {:ok, nation: nation}
  end
end
