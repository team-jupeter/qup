defmodule DemoWeb.GabAccountControllerTest do
  use DemoWeb.ConnCase

  alias Demo.GabAccounts

  @create_attrs %{credit_limit: "some credit_limit", owner: "some owner", t1: "some t1", t2: "some t2", t3: "some t3"}
  @update_attrs %{credit_limit: "some updated credit_limit", owner: "some updated owner", t1: "some updated t1", t2: "some updated t2", t3: "some updated t3"}
  @invalid_attrs %{credit_limit: nil, owner: nil, t1: nil, t2: nil, t3: nil}

  def fixture(:gab_account) do
    {:ok, gab_account} = GabAccounts.create_gab_account(@create_attrs)
    gab_account
  end

  describe "index" do
    test "lists all gab_accounts", %{conn: conn} do
      conn = get(conn, Routes.gab_account_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Gab accounts"
    end
  end

  describe "new gab_account" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.gab_account_path(conn, :new))
      assert html_response(conn, 200) =~ "New Gab account"
    end
  end

  describe "create gab_account" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.gab_account_path(conn, :create), gab_account: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.gab_account_path(conn, :show, id)

      conn = get(conn, Routes.gab_account_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Gab account"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.gab_account_path(conn, :create), gab_account: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Gab account"
    end
  end

  describe "edit gab_account" do
    setup [:create_gab_account]

    test "renders form for editing chosen gab_account", %{conn: conn, gab_account: gab_account} do
      conn = get(conn, Routes.gab_account_path(conn, :edit, gab_account))
      assert html_response(conn, 200) =~ "Edit Gab account"
    end
  end

  describe "update gab_account" do
    setup [:create_gab_account]

    test "redirects when data is valid", %{conn: conn, gab_account: gab_account} do
      conn = put(conn, Routes.gab_account_path(conn, :update, gab_account), gab_account: @update_attrs)
      assert redirected_to(conn) == Routes.gab_account_path(conn, :show, gab_account)

      conn = get(conn, Routes.gab_account_path(conn, :show, gab_account))
      assert html_response(conn, 200) =~ "some updated credit_limit"
    end

    test "renders errors when data is invalid", %{conn: conn, gab_account: gab_account} do
      conn = put(conn, Routes.gab_account_path(conn, :update, gab_account), gab_account: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Gab account"
    end
  end

  describe "delete gab_account" do
    setup [:create_gab_account]

    test "deletes chosen gab_account", %{conn: conn, gab_account: gab_account} do
      conn = delete(conn, Routes.gab_account_path(conn, :delete, gab_account))
      assert redirected_to(conn) == Routes.gab_account_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.gab_account_path(conn, :show, gab_account))
      end
    end
  end

  defp create_gab_account(_) do
    gab_account = fixture(:gab_account)
    {:ok, gab_account: gab_account}
  end
end
