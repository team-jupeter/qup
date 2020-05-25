defmodule Demo.CarsTest do
  use Demo.DataCase

  alias Demo.Cars

  describe "cars" do
    alias Demo.Cars.Car

    @valid_attrs %{category: "some category", current_cargo_amount: "some current_cargo_amount", current_cargo_type: "some current_cargo_type", current_location: "some current_location", destination: "some destination", location_history: "some location_history", moving: "some moving", production_date: ~N[2010-04-17 14:00:00], status: "some status"}
    @update_attrs %{category: "some updated category", current_cargo_amount: "some updated current_cargo_amount", current_cargo_type: "some updated current_cargo_type", current_location: "some updated current_location", destination: "some updated destination", location_history: "some updated location_history", moving: "some updated moving", production_date: ~N[2011-05-18 15:01:01], status: "some updated status"}
    @invalid_attrs %{category: nil, current_cargo_amount: nil, current_cargo_type: nil, current_location: nil, destination: nil, location_history: nil, moving: nil, production_date: nil, status: nil}

    def car_fixture(attrs \\ %{}) do
      {:ok, car} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cars.create_car()

      car
    end

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Cars.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Cars.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      assert {:ok, %Car{} = car} = Cars.create_car(@valid_attrs)
      assert car.category == "some category"
      assert car.current_cargo_amount == "some current_cargo_amount"
      assert car.current_cargo_type == "some current_cargo_type"
      assert car.current_location == "some current_location"
      assert car.destination == "some destination"
      assert car.location_history == "some location_history"
      assert car.moving == "some moving"
      assert car.production_date == ~N[2010-04-17 14:00:00]
      assert car.status == "some status"
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cars.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      assert {:ok, %Car{} = car} = Cars.update_car(car, @update_attrs)
      assert car.category == "some updated category"
      assert car.current_cargo_amount == "some updated current_cargo_amount"
      assert car.current_cargo_type == "some updated current_cargo_type"
      assert car.current_location == "some updated current_location"
      assert car.destination == "some updated destination"
      assert car.location_history == "some updated location_history"
      assert car.moving == "some updated moving"
      assert car.production_date == ~N[2011-05-18 15:01:01]
      assert car.status == "some updated status"
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Cars.update_car(car, @invalid_attrs)
      assert car == Cars.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Cars.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Cars.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Cars.change_car(car)
    end
  end
end
