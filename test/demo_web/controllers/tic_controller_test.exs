defmodule DemoWeb.TicControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Tics

  @create_attrs %{datetime: ~N[2010-04-17 14:00:00]}
  @update_attrs %{datetime: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{datetime: nil}

  def fixture(:tic) do
    {:ok, tic} = Tics.create_tic(@create_attrs)
    tic
  end

  describe "index" do
    test "lists all tics", %{conn: conn} do
      conn = get(conn, Routes.tic_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tics"
    end
  end

  describe "new tic" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tic_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tic"
    end
  end

  describe "create tic" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tic_path(conn, :create), tic: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tic_path(conn, :show, id)

      conn = get(conn, Routes.tic_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tic"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tic_path(conn, :create), tic: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tic"
    end
  end

  describe "edit tic" do
    setup [:create_tic]

    test "renders form for editing chosen tic", %{conn: conn, tic: tic} do
      conn = get(conn, Routes.tic_path(conn, :edit, tic))
      assert html_response(conn, 200) =~ "Edit Tic"
    end
  end

  describe "update tic" do
    setup [:create_tic]

    test "redirects when data is valid", %{conn: conn, tic: tic} do
      conn = put(conn, Routes.tic_path(conn, :update, tic), tic: @update_attrs)
      assert redirected_to(conn) == Routes.tic_path(conn, :show, tic)

      conn = get(conn, Routes.tic_path(conn, :show, tic))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, tic: tic} do
      conn = put(conn, Routes.tic_path(conn, :update, tic), tic: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tic"
    end
  end

  describe "delete tic" do
    setup [:create_tic]

    test "deletes chosen tic", %{conn: conn, tic: tic} do
      conn = delete(conn, Routes.tic_path(conn, :delete, tic))
      assert redirected_to(conn) == Routes.tic_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tic_path(conn, :show, tic))
      end
    end
  end

  defp create_tic(_) do
    tic = fixture(:tic)
    {:ok, tic: tic}
  end
end
