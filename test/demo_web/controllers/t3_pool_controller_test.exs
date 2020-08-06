defmodule DemoWeb.T3ListControllerTest do
  use DemoWeb.ConnCase

  alias Demo.T3Lists

  @create_attrs %{num_of_stocks: "some num_of_stocks", price_per_share: "some price_per_share"}
  @update_attrs %{num_of_stocks: "some updated num_of_stocks", price_per_share: "some updated price_per_share"}
  @invalid_attrs %{num_of_stocks: nil, price_per_share: nil}

  def fixture(:t3_list) do
    {:ok, t3_list} = T3Lists.create_t3_list(@create_attrs)
    t3_list
  end

  describe "index" do
    test "lists all t3_lists", %{conn: conn} do
      conn = get(conn, Routes.t3_list_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing T3 lists"
    end
  end

  describe "new t3_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.t3_list_path(conn, :new))
      assert html_response(conn, 200) =~ "New T3 list"
    end
  end

  describe "create t3_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.t3_list_path(conn, :create), t3_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.t3_list_path(conn, :show, id)

      conn = get(conn, Routes.t3_list_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show T3 list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.t3_list_path(conn, :create), t3_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New T3 list"
    end
  end

  describe "edit t3_list" do
    setup [:create_t3_list]

    test "renders form for editing chosen t3_list", %{conn: conn, t3_list: t3_list} do
      conn = get(conn, Routes.t3_list_path(conn, :edit, t3_list))
      assert html_response(conn, 200) =~ "Edit T3 list"
    end
  end

  describe "update t3_list" do
    setup [:create_t3_list]

    test "redirects when data is valid", %{conn: conn, t3_list: t3_list} do
      conn = put(conn, Routes.t3_list_path(conn, :update, t3_list), t3_list: @update_attrs)
      assert redirected_to(conn) == Routes.t3_list_path(conn, :show, t3_list)

      conn = get(conn, Routes.t3_list_path(conn, :show, t3_list))
      assert html_response(conn, 200) =~ "some updated num_of_stocks"
    end

    test "renders errors when data is invalid", %{conn: conn, t3_list: t3_list} do
      conn = put(conn, Routes.t3_list_path(conn, :update, t3_list), t3_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit T3 list"
    end
  end

  describe "delete t3_list" do
    setup [:create_t3_list]

    test "deletes chosen t3_list", %{conn: conn, t3_list: t3_list} do
      conn = delete(conn, Routes.t3_list_path(conn, :delete, t3_list))
      assert redirected_to(conn) == Routes.t3_list_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.t3_list_path(conn, :show, t3_list))
      end
    end
  end

  defp create_t3_list(_) do
    t3_list = fixture(:t3_list)
    {:ok, t3_list: t3_list}
  end
end
