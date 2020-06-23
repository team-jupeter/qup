defmodule DemoWeb.AssetControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Assets

  @create_attrs %{name: "some name", owners: "some owners", type: "some type"}
  @update_attrs %{name: "some updated name", owners: "some updated owners", type: "some updated type"}
  @invalid_attrs %{name: nil, owners: nil, type: nil}

  def fixture(:asset) do
    {:ok, asset} = Assets.create_asset(@create_attrs)
    asset
  end

  describe "index" do
    test "lists all assets", %{conn: conn} do
      conn = get(conn, Routes.asset_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Assets"
    end
  end

  describe "new asset" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.asset_path(conn, :new))
      assert html_response(conn, 200) =~ "New Asset"
    end
  end

  describe "create asset" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.asset_path(conn, :create), asset: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.asset_path(conn, :show, id)

      conn = get(conn, Routes.asset_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Asset"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.asset_path(conn, :create), asset: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Asset"
    end
  end

  describe "edit asset" do
    setup [:create_asset]

    test "renders form for editing chosen asset", %{conn: conn, asset: asset} do
      conn = get(conn, Routes.asset_path(conn, :edit, asset))
      assert html_response(conn, 200) =~ "Edit Asset"
    end
  end

  describe "update asset" do
    setup [:create_asset]

    test "redirects when data is valid", %{conn: conn, asset: asset} do
      conn = put(conn, Routes.asset_path(conn, :update, asset), asset: @update_attrs)
      assert redirected_to(conn) == Routes.asset_path(conn, :show, asset)

      conn = get(conn, Routes.asset_path(conn, :show, asset))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, asset: asset} do
      conn = put(conn, Routes.asset_path(conn, :update, asset), asset: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Asset"
    end
  end

  describe "delete asset" do
    setup [:create_asset]

    test "deletes chosen asset", %{conn: conn, asset: asset} do
      conn = delete(conn, Routes.asset_path(conn, :delete, asset))
      assert redirected_to(conn) == Routes.asset_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.asset_path(conn, :show, asset))
      end
    end
  end

  defp create_asset(_) do
    asset = fixture(:asset)
    {:ok, asset: asset}
  end
end
