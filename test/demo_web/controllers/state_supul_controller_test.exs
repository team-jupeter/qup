defmodule DemoWeb.StateSupulControllerTest do
  use DemoWeb.ConnCase

  alias Demo.StateSupuls

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:state_supul) do
    {:ok, state_supul} = StateSupuls.create_state_supul(@create_attrs)
    state_supul
  end

  describe "index" do
    test "lists all state_supuls", %{conn: conn} do
      conn = get(conn, Routes.state_supul_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing State supuls"
    end
  end

  describe "new state_supul" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.state_supul_path(conn, :new))
      assert html_response(conn, 200) =~ "New State supul"
    end
  end

  describe "create state_supul" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.state_supul_path(conn, :create), state_supul: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.state_supul_path(conn, :show, id)

      conn = get(conn, Routes.state_supul_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show State supul"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.state_supul_path(conn, :create), state_supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "New State supul"
    end
  end

  describe "edit state_supul" do
    setup [:create_state_supul]

    test "renders form for editing chosen state_supul", %{conn: conn, state_supul: state_supul} do
      conn = get(conn, Routes.state_supul_path(conn, :edit, state_supul))
      assert html_response(conn, 200) =~ "Edit State supul"
    end
  end

  describe "update state_supul" do
    setup [:create_state_supul]

    test "redirects when data is valid", %{conn: conn, state_supul: state_supul} do
      conn = put(conn, Routes.state_supul_path(conn, :update, state_supul), state_supul: @update_attrs)
      assert redirected_to(conn) == Routes.state_supul_path(conn, :show, state_supul)

      conn = get(conn, Routes.state_supul_path(conn, :show, state_supul))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, state_supul: state_supul} do
      conn = put(conn, Routes.state_supul_path(conn, :update, state_supul), state_supul: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit State supul"
    end
  end

  describe "delete state_supul" do
    setup [:create_state_supul]

    test "deletes chosen state_supul", %{conn: conn, state_supul: state_supul} do
      conn = delete(conn, Routes.state_supul_path(conn, :delete, state_supul))
      assert redirected_to(conn) == Routes.state_supul_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.state_supul_path(conn, :show, state_supul))
      end
    end
  end

  defp create_state_supul(_) do
    state_supul = fixture(:state_supul)
    {:ok, state_supul: state_supul}
  end
end
