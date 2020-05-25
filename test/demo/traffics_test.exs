defmodule Demo.TrafficsTest do
  use Demo.DataCase

  alias Demo.Traffics

  describe "traffics" do
    alias Demo.Traffics.Traffic

    @valid_attrs %{air_routes: "some air_routes", airline_amount: "some airline_amount", car_amount: "some car_amount", land_routes: "some land_routes", ship_amount: "some ship_amount", water_routes: "some water_routes"}
    @update_attrs %{air_routes: "some updated air_routes", airline_amount: "some updated airline_amount", car_amount: "some updated car_amount", land_routes: "some updated land_routes", ship_amount: "some updated ship_amount", water_routes: "some updated water_routes"}
    @invalid_attrs %{air_routes: nil, airline_amount: nil, car_amount: nil, land_routes: nil, ship_amount: nil, water_routes: nil}

    def traffic_fixture(attrs \\ %{}) do
      {:ok, traffic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Traffics.create_traffic()

      traffic
    end

    test "list_traffics/0 returns all traffics" do
      traffic = traffic_fixture()
      assert Traffics.list_traffics() == [traffic]
    end

    test "get_traffic!/1 returns the traffic with given id" do
      traffic = traffic_fixture()
      assert Traffics.get_traffic!(traffic.id) == traffic
    end

    test "create_traffic/1 with valid data creates a traffic" do
      assert {:ok, %Traffic{} = traffic} = Traffics.create_traffic(@valid_attrs)
      assert traffic.air_routes == "some air_routes"
      assert traffic.airline_amount == "some airline_amount"
      assert traffic.car_amount == "some car_amount"
      assert traffic.land_routes == "some land_routes"
      assert traffic.ship_amount == "some ship_amount"
      assert traffic.water_routes == "some water_routes"
    end

    test "create_traffic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Traffics.create_traffic(@invalid_attrs)
    end

    test "update_traffic/2 with valid data updates the traffic" do
      traffic = traffic_fixture()
      assert {:ok, %Traffic{} = traffic} = Traffics.update_traffic(traffic, @update_attrs)
      assert traffic.air_routes == "some updated air_routes"
      assert traffic.airline_amount == "some updated airline_amount"
      assert traffic.car_amount == "some updated car_amount"
      assert traffic.land_routes == "some updated land_routes"
      assert traffic.ship_amount == "some updated ship_amount"
      assert traffic.water_routes == "some updated water_routes"
    end

    test "update_traffic/2 with invalid data returns error changeset" do
      traffic = traffic_fixture()
      assert {:error, %Ecto.Changeset{}} = Traffics.update_traffic(traffic, @invalid_attrs)
      assert traffic == Traffics.get_traffic!(traffic.id)
    end

    test "delete_traffic/1 deletes the traffic" do
      traffic = traffic_fixture()
      assert {:ok, %Traffic{}} = Traffics.delete_traffic(traffic)
      assert_raise Ecto.NoResultsError, fn -> Traffics.get_traffic!(traffic.id) end
    end

    test "change_traffic/1 returns a traffic changeset" do
      traffic = traffic_fixture()
      assert %Ecto.Changeset{} = Traffics.change_traffic(traffic)
    end
  end
end
