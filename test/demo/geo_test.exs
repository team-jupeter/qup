defmodule Demo.GeoTest do
  use Demo.DataCase

  alias Demo.Geo

  describe "addresses" do
    alias Demo.Geo.Address

    @valid_attrs %{city: "some city"}
    @update_attrs %{city: "some updated city"}
    @invalid_attrs %{city: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Geo.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Geo.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Geo.create_address(@valid_attrs)
      assert address.city == "some city"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Geo.update_address(address, @update_attrs)
      assert address.city == "some updated city"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_address(address, @invalid_attrs)
      assert address == Geo.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Geo.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Geo.change_address(address)
    end
  end

  describe "addresses" do
    alias Demo.Geo.Address

    @valid_attrs %{city: "some city", nation: "some nation", state: "some state", street: "some street"}
    @update_attrs %{city: "some updated city", nation: "some updated nation", state: "some updated state", street: "some updated street"}
    @invalid_attrs %{city: nil, nation: nil, state: nil, street: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Geo.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Geo.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Geo.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Geo.create_address(@valid_attrs)
      assert address.city == "some city"
      assert address.nation == "some nation"
      assert address.state == "some state"
      assert address.street == "some street"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Geo.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Geo.update_address(address, @update_attrs)
      assert address.city == "some updated city"
      assert address.nation == "some updated nation"
      assert address.state == "some updated state"
      assert address.street == "some updated street"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Geo.update_address(address, @invalid_attrs)
      assert address == Geo.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Geo.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Geo.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Geo.change_address(address)
    end
  end
end
