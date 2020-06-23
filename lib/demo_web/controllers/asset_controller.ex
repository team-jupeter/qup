defmodule DemoWeb.AssetController do
  use DemoWeb, :controller

  alias Demo.Assets
  alias Demo.Assets.Asset

  def index(conn, _params) do
    assets = Assets.list_assets()
    render(conn, "index.html", assets: assets)
  end

  def new(conn, _params) do
    changeset = Assets.change_asset(%Asset{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"asset" => asset_params}) do
    case Assets.create_asset(asset_params) do
      {:ok, asset} ->
        conn
        |> put_flash(:info, "Asset created successfully.")
        |> redirect(to: Routes.asset_path(conn, :show, asset))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)
    render(conn, "show.html", asset: asset)
  end

  def edit(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)
    changeset = Assets.change_asset(asset)
    render(conn, "edit.html", asset: asset, changeset: changeset)
  end

  def update(conn, %{"id" => id, "asset" => asset_params}) do
    asset = Assets.get_asset!(id)

    case Assets.update_asset(asset, asset_params) do
      {:ok, asset} ->
        conn
        |> put_flash(:info, "Asset updated successfully.")
        |> redirect(to: Routes.asset_path(conn, :show, asset))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", asset: asset, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = Assets.get_asset!(id)
    {:ok, _asset} = Assets.delete_asset(asset)

    conn
    |> put_flash(:info, "Asset deleted successfully.")
    |> redirect(to: Routes.asset_path(conn, :index))
  end
end
