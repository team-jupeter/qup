defmodule Demo.PortalsTest do
  use Demo.DataCase

  alias Demo.Portals

  describe "portals" do
    alias Demo.Portals.Portal

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def portal_fixture(attrs \\ %{}) do
      {:ok, portal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Portals.create_portal()

      portal
    end

    test "list_portals/0 returns all portals" do
      portal = portal_fixture()
      assert Portals.list_portals() == [portal]
    end

    test "get_portal!/1 returns the portal with given id" do
      portal = portal_fixture()
      assert Portals.get_portal!(portal.id) == portal
    end

    test "create_portal/1 with valid data creates a portal" do
      assert {:ok, %Portal{} = portal} = Portals.create_portal(@valid_attrs)
      assert portal.name == "some name"
    end

    test "create_portal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Portals.create_portal(@invalid_attrs)
    end

    test "update_portal/2 with valid data updates the portal" do
      portal = portal_fixture()
      assert {:ok, %Portal{} = portal} = Portals.update_portal(portal, @update_attrs)
      assert portal.name == "some updated name"
    end

    test "update_portal/2 with invalid data returns error changeset" do
      portal = portal_fixture()
      assert {:error, %Ecto.Changeset{}} = Portals.update_portal(portal, @invalid_attrs)
      assert portal == Portals.get_portal!(portal.id)
    end

    test "delete_portal/1 deletes the portal" do
      portal = portal_fixture()
      assert {:ok, %Portal{}} = Portals.delete_portal(portal)
      assert_raise Ecto.NoResultsError, fn -> Portals.get_portal!(portal.id) end
    end

    test "change_portal/1 returns a portal changeset" do
      portal = portal_fixture()
      assert %Ecto.Changeset{} = Portals.change_portal(portal)
    end
  end
end
