defmodule Demo.AirportsTest do
  use Demo.DataCase

  alias Demo.Airports

  describe "airports" do
    alias Demo.Airports.Airport

    @valid_attrs %{address: "some address", name: "some name", nationality: "some nationality", tel: "some tel"}
    @update_attrs %{address: "some updated address", name: "some updated name", nationality: "some updated nationality", tel: "some updated tel"}
    @invalid_attrs %{address: nil, name: nil, nationality: nil, tel: nil}

    def airport_fixture(attrs \\ %{}) do
      {:ok, airport} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Airports.create_airport()

      airport
    end

    test "list_airports/0 returns all airports" do
      airport = airport_fixture()
      assert Airports.list_airports() == [airport]
    end

    test "get_airport!/1 returns the airport with given id" do
      airport = airport_fixture()
      assert Airports.get_airport!(airport.id) == airport
    end

    test "create_airport/1 with valid data creates a airport" do
      assert {:ok, %Airport{} = airport} = Airports.create_airport(@valid_attrs)
      assert airport.address == "some address"
      assert airport.name == "some name"
      assert airport.nationality == "some nationality"
      assert airport.tel == "some tel"
    end

    test "create_airport/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Airports.create_airport(@invalid_attrs)
    end

    test "update_airport/2 with valid data updates the airport" do
      airport = airport_fixture()
      assert {:ok, %Airport{} = airport} = Airports.update_airport(airport, @update_attrs)
      assert airport.address == "some updated address"
      assert airport.name == "some updated name"
      assert airport.nationality == "some updated nationality"
      assert airport.tel == "some updated tel"
    end

    test "update_airport/2 with invalid data returns error changeset" do
      airport = airport_fixture()
      assert {:error, %Ecto.Changeset{}} = Airports.update_airport(airport, @invalid_attrs)
      assert airport == Airports.get_airport!(airport.id)
    end

    test "delete_airport/1 deletes the airport" do
      airport = airport_fixture()
      assert {:ok, %Airport{}} = Airports.delete_airport(airport)
      assert_raise Ecto.NoResultsError, fn -> Airports.get_airport!(airport.id) end
    end

    test "change_airport/1 returns a airport changeset" do
      airport = airport_fixture()
      assert %Ecto.Changeset{} = Airports.change_airport(airport)
    end
  end
end
