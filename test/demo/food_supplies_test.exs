defmodule Demo.FoodSuppliesTest do
  use Demo.DataCase

  alias Demo.FoodSupplies

  describe "food_supplies" do
    alias Demo.FoodSupplies.FoodSupply

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def food_supply_fixture(attrs \\ %{}) do
      {:ok, food_supply} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FoodSupplies.create_food_supply()

      food_supply
    end

    test "list_food_supplies/0 returns all food_supplies" do
      food_supply = food_supply_fixture()
      assert FoodSupplies.list_food_supplies() == [food_supply]
    end

    test "get_food_supply!/1 returns the food_supply with given id" do
      food_supply = food_supply_fixture()
      assert FoodSupplies.get_food_supply!(food_supply.id) == food_supply
    end

    test "create_food_supply/1 with valid data creates a food_supply" do
      assert {:ok, %FoodSupply{} = food_supply} = FoodSupplies.create_food_supply(@valid_attrs)
    end

    test "create_food_supply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodSupplies.create_food_supply(@invalid_attrs)
    end

    test "update_food_supply/2 with valid data updates the food_supply" do
      food_supply = food_supply_fixture()
      assert {:ok, %FoodSupply{} = food_supply} = FoodSupplies.update_food_supply(food_supply, @update_attrs)
    end

    test "update_food_supply/2 with invalid data returns error changeset" do
      food_supply = food_supply_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodSupplies.update_food_supply(food_supply, @invalid_attrs)
      assert food_supply == FoodSupplies.get_food_supply!(food_supply.id)
    end

    test "delete_food_supply/1 deletes the food_supply" do
      food_supply = food_supply_fixture()
      assert {:ok, %FoodSupply{}} = FoodSupplies.delete_food_supply(food_supply)
      assert_raise Ecto.NoResultsError, fn -> FoodSupplies.get_food_supply!(food_supply.id) end
    end

    test "change_food_supply/1 returns a food_supply changeset" do
      food_supply = food_supply_fixture()
      assert %Ecto.Changeset{} = FoodSupplies.change_food_supply(food_supply)
    end
  end
end
