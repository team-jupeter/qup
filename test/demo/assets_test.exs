defmodule Demo.AssetsTest do
  use Demo.DataCase

  alias Demo.Assets

  describe "assets" do
    alias Demo.Assets.Asset

    @valid_attrs %{name: "some name", owners: "some owners", type: "some type"}
    @update_attrs %{name: "some updated name", owners: "some updated owners", type: "some updated type"}
    @invalid_attrs %{name: nil, owners: nil, type: nil}

    def asset_fixture(attrs \\ %{}) do
      {:ok, asset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Assets.create_asset()

      asset
    end

    test "list_assets/0 returns all assets" do
      asset = asset_fixture()
      assert Assets.list_assets() == [asset]
    end

    test "get_asset!/1 returns the asset with given id" do
      asset = asset_fixture()
      assert Assets.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset" do
      assert {:ok, %Asset{} = asset} = Assets.create_asset(@valid_attrs)
      assert asset.name == "some name"
      assert asset.owners == "some owners"
      assert asset.type == "some type"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{} = asset} = Assets.update_asset(asset, @update_attrs)
      assert asset.name == "some updated name"
      assert asset.owners == "some updated owners"
      assert asset.type == "some updated type"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()
      assert {:error, %Ecto.Changeset{}} = Assets.update_asset(asset, @invalid_attrs)
      assert asset == Assets.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{}} = Assets.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset" do
      asset = asset_fixture()
      assert %Ecto.Changeset{} = Assets.change_asset(asset)
    end
  end
end
