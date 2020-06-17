defmodule DemoWeb.ConstitutionControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Constitutions

  @create_attrs %{hash: "some hash", private_key: "some private_key", text: "some text"}
  @update_attrs %{hash: "some updated hash", private_key: "some updated private_key", text: "some updated text"}
  @invalid_attrs %{hash: nil, private_key: nil, text: nil}

  def fixture(:constitution) do
    {:ok, constitution} = Constitutions.create_constitution(@create_attrs)
    constitution
  end

  describe "index" do
    test "lists all constitutions", %{conn: conn} do
      conn = get(conn, Routes.constitution_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Constitutions"
    end
  end

  describe "new constitution" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.constitution_path(conn, :new))
      assert html_response(conn, 200) =~ "New Constitution"
    end
  end

  describe "create constitution" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.constitution_path(conn, :create), constitution: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.constitution_path(conn, :show, id)

      conn = get(conn, Routes.constitution_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Constitution"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.constitution_path(conn, :create), constitution: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Constitution"
    end
  end

  describe "edit constitution" do
    setup [:create_constitution]

    test "renders form for editing chosen constitution", %{conn: conn, constitution: constitution} do
      conn = get(conn, Routes.constitution_path(conn, :edit, constitution))
      assert html_response(conn, 200) =~ "Edit Constitution"
    end
  end

  describe "update constitution" do
    setup [:create_constitution]

    test "redirects when data is valid", %{conn: conn, constitution: constitution} do
      conn = put(conn, Routes.constitution_path(conn, :update, constitution), constitution: @update_attrs)
      assert redirected_to(conn) == Routes.constitution_path(conn, :show, constitution)

      conn = get(conn, Routes.constitution_path(conn, :show, constitution))
      assert html_response(conn, 200) =~ "some updated hash"
    end

    test "renders errors when data is invalid", %{conn: conn, constitution: constitution} do
      conn = put(conn, Routes.constitution_path(conn, :update, constitution), constitution: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Constitution"
    end
  end

  describe "delete constitution" do
    setup [:create_constitution]

    test "deletes chosen constitution", %{conn: conn, constitution: constitution} do
      conn = delete(conn, Routes.constitution_path(conn, :delete, constitution))
      assert redirected_to(conn) == Routes.constitution_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.constitution_path(conn, :show, constitution))
      end
    end
  end

  defp create_constitution(_) do
    constitution = fixture(:constitution)
    {:ok, constitution: constitution}
  end
end
