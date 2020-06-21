defmodule DemoWeb.TxnControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Txns

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:txn) do
    {:ok, txn} = Txns.create_txn(@create_attrs)
    txn
  end

  describe "index" do
    test "lists all txns", %{conn: conn} do
      conn = get(conn, Routes.txn_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Txns"
    end
  end

  describe "new txn" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.txn_path(conn, :new))
      assert html_response(conn, 200) =~ "New Txn"
    end
  end

  describe "create txn" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.txn_path(conn, :create), txn: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.txn_path(conn, :show, id)

      conn = get(conn, Routes.txn_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Txn"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.txn_path(conn, :create), txn: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Txn"
    end
  end

  describe "edit txn" do
    setup [:create_txn]

    test "renders form for editing chosen txn", %{conn: conn, txn: txn} do
      conn = get(conn, Routes.txn_path(conn, :edit, txn))
      assert html_response(conn, 200) =~ "Edit Txn"
    end
  end

  describe "update txn" do
    setup [:create_txn]

    test "redirects when data is valid", %{conn: conn, txn: txn} do
      conn = put(conn, Routes.txn_path(conn, :update, txn), txn: @update_attrs)
      assert redirected_to(conn) == Routes.txn_path(conn, :show, txn)

      conn = get(conn, Routes.txn_path(conn, :show, txn))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, txn: txn} do
      conn = put(conn, Routes.txn_path(conn, :update, txn), txn: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Txn"
    end
  end

  describe "delete txn" do
    setup [:create_txn]

    test "deletes chosen txn", %{conn: conn, txn: txn} do
      conn = delete(conn, Routes.txn_path(conn, :delete, txn))
      assert redirected_to(conn) == Routes.txn_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.txn_path(conn, :show, txn))
      end
    end
  end

  defp create_txn(_) do
    txn = fixture(:txn)
    {:ok, txn: txn}
  end
end
