defmodule DemoWeb.WeddingControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Weddings

  @create_attrs %{bride: "some bride", groom: "some groom"}
  @update_attrs %{bride: "some updated bride", groom: "some updated groom"}
  @invalid_attrs %{bride: nil, groom: nil}

  def fixture(:wedding) do
    {:ok, wedding} = Weddings.create_wedding(@create_attrs)
    wedding
  end

  describe "index" do
    test "lists all weddings", %{conn: conn} do
      conn = get(conn, Routes.wedding_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Weddings"
    end
  end

  describe "new wedding" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.wedding_path(conn, :new))
      assert html_response(conn, 200) =~ "New Wedding"
    end
  end

  describe "create wedding" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.wedding_path(conn, :create), wedding: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.wedding_path(conn, :show, id)

      conn = get(conn, Routes.wedding_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Wedding"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.wedding_path(conn, :create), wedding: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Wedding"
    end
  end

  describe "edit wedding" do
    setup [:create_wedding]

    test "renders form for editing chosen wedding", %{conn: conn, wedding: wedding} do
      conn = get(conn, Routes.wedding_path(conn, :edit, wedding))
      assert html_response(conn, 200) =~ "Edit Wedding"
    end
  end

  describe "update wedding" do
    setup [:create_wedding]

    test "redirects when data is valid", %{conn: conn, wedding: wedding} do
      conn = put(conn, Routes.wedding_path(conn, :update, wedding), wedding: @update_attrs)
      assert redirected_to(conn) == Routes.wedding_path(conn, :show, wedding)

      conn = get(conn, Routes.wedding_path(conn, :show, wedding))
      assert html_response(conn, 200) =~ "some updated bride"
    end

    test "renders errors when data is invalid", %{conn: conn, wedding: wedding} do
      conn = put(conn, Routes.wedding_path(conn, :update, wedding), wedding: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Wedding"
    end
  end

  describe "delete wedding" do
    setup [:create_wedding]

    test "deletes chosen wedding", %{conn: conn, wedding: wedding} do
      conn = delete(conn, Routes.wedding_path(conn, :delete, wedding))
      assert redirected_to(conn) == Routes.wedding_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.wedding_path(conn, :show, wedding))
      end
    end
  end

  defp create_wedding(_) do
    wedding = fixture(:wedding)
    {:ok, wedding: wedding}
  end
end
