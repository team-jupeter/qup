defmodule Demo.SupulsTest do
  use Demo.DataCase

  alias Demo.Supuls

  describe "supuls" do
    alias Demo.Supuls.Supul

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def supul_fixture(attrs \\ %{}) do
      {:ok, supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Supuls.create_supul()

      supul
    end

    test "list_supuls/0 returns all supuls" do
      supul = supul_fixture()
      assert Supuls.list_supuls() == [supul]
    end

    test "get_supul!/1 returns the supul with given id" do
      supul = supul_fixture()
      assert Supuls.get_supul!(supul.id) == supul
    end

    test "create_supul/1 with valid data creates a supul" do
      assert {:ok, %Supul{} = supul} = Supuls.create_supul(@valid_attrs)
      assert supul.name == "some name"
    end

    test "create_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supuls.create_supul(@invalid_attrs)
    end

    test "update_supul/2 with valid data updates the supul" do
      supul = supul_fixture()
      assert {:ok, %Supul{} = supul} = Supuls.update_supul(supul, @update_attrs)
      assert supul.name == "some updated name"
    end

    test "update_supul/2 with invalid data returns error changeset" do
      supul = supul_fixture()
      assert {:error, %Ecto.Changeset{}} = Supuls.update_supul(supul, @invalid_attrs)
      assert supul == Supuls.get_supul!(supul.id)
    end

    test "delete_supul/1 deletes the supul" do
      supul = supul_fixture()
      assert {:ok, %Supul{}} = Supuls.delete_supul(supul)
      assert_raise Ecto.NoResultsError, fn -> Supuls.get_supul!(supul.id) end
    end

    test "change_supul/1 returns a supul changeset" do
      supul = supul_fixture()
      assert %Ecto.Changeset{} = Supuls.change_supul(supul)
    end
  end

  describe "unit_supuls" do
    alias Demo.Supuls.UnitSupul

    @valid_attrs %{geographical_area: "some geographical_area", name: "some name", nationality: "some nationality"}
    @update_attrs %{geographical_area: "some updated geographical_area", name: "some updated name", nationality: "some updated nationality"}
    @invalid_attrs %{geographical_area: nil, name: nil, nationality: nil}

    def unit_supul_fixture(attrs \\ %{}) do
      {:ok, unit_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Supuls.create_unit_supul()

      unit_supul
    end

    test "list_unit_supuls/0 returns all unit_supuls" do
      unit_supul = unit_supul_fixture()
      assert Supuls.list_unit_supuls() == [unit_supul]
    end

    test "get_unit_supul!/1 returns the unit_supul with given id" do
      unit_supul = unit_supul_fixture()
      assert Supuls.get_unit_supul!(unit_supul.id) == unit_supul
    end

    test "create_unit_supul/1 with valid data creates a unit_supul" do
      assert {:ok, %UnitSupul{} = unit_supul} = Supuls.create_unit_supul(@valid_attrs)
      assert unit_supul.geographical_area == "some geographical_area"
      assert unit_supul.name == "some name"
      assert unit_supul.nationality == "some nationality"
    end

    test "create_unit_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supuls.create_unit_supul(@invalid_attrs)
    end

    test "update_unit_supul/2 with valid data updates the unit_supul" do
      unit_supul = unit_supul_fixture()
      assert {:ok, %UnitSupul{} = unit_supul} = Supuls.update_unit_supul(unit_supul, @update_attrs)
      assert unit_supul.geographical_area == "some updated geographical_area"
      assert unit_supul.name == "some updated name"
      assert unit_supul.nationality == "some updated nationality"
    end

    test "update_unit_supul/2 with invalid data returns error changeset" do
      unit_supul = unit_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = Supuls.update_unit_supul(unit_supul, @invalid_attrs)
      assert unit_supul == Supuls.get_unit_supul!(unit_supul.id)
    end

    test "delete_unit_supul/1 deletes the unit_supul" do
      unit_supul = unit_supul_fixture()
      assert {:ok, %UnitSupul{}} = Supuls.delete_unit_supul(unit_supul)
      assert_raise Ecto.NoResultsError, fn -> Supuls.get_unit_supul!(unit_supul.id) end
    end

    test "change_unit_supul/1 returns a unit_supul changeset" do
      unit_supul = unit_supul_fixture()
      assert %Ecto.Changeset{} = Supuls.change_unit_supul(unit_supul)
    end
  end

  describe "state_supuls" do
    alias Demo.Supuls.StateSupul

    @valid_attrs %{geographical_area: "some geographical_area", name: "some name", nationality: "some nationality"}
    @update_attrs %{geographical_area: "some updated geographical_area", name: "some updated name", nationality: "some updated nationality"}
    @invalid_attrs %{geographical_area: nil, name: nil, nationality: nil}

    def state_supul_fixture(attrs \\ %{}) do
      {:ok, state_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Supuls.create_state_supul()

      state_supul
    end

    test "list_state_supuls/0 returns all state_supuls" do
      state_supul = state_supul_fixture()
      assert Supuls.list_state_supuls() == [state_supul]
    end

    test "get_state_supul!/1 returns the state_supul with given id" do
      state_supul = state_supul_fixture()
      assert Supuls.get_state_supul!(state_supul.id) == state_supul
    end

    test "create_state_supul/1 with valid data creates a state_supul" do
      assert {:ok, %StateSupul{} = state_supul} = Supuls.create_state_supul(@valid_attrs)
      assert state_supul.geographical_area == "some geographical_area"
      assert state_supul.name == "some name"
      assert state_supul.nationality == "some nationality"
    end

    test "create_state_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supuls.create_state_supul(@invalid_attrs)
    end

    test "update_state_supul/2 with valid data updates the state_supul" do
      state_supul = state_supul_fixture()
      assert {:ok, %StateSupul{} = state_supul} = Supuls.update_state_supul(state_supul, @update_attrs)
      assert state_supul.geographical_area == "some updated geographical_area"
      assert state_supul.name == "some updated name"
      assert state_supul.nationality == "some updated nationality"
    end

    test "update_state_supul/2 with invalid data returns error changeset" do
      state_supul = state_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = Supuls.update_state_supul(state_supul, @invalid_attrs)
      assert state_supul == Supuls.get_state_supul!(state_supul.id)
    end

    test "delete_state_supul/1 deletes the state_supul" do
      state_supul = state_supul_fixture()
      assert {:ok, %StateSupul{}} = Supuls.delete_state_supul(state_supul)
      assert_raise Ecto.NoResultsError, fn -> Supuls.get_state_supul!(state_supul.id) end
    end

    test "change_state_supul/1 returns a state_supul changeset" do
      state_supul = state_supul_fixture()
      assert %Ecto.Changeset{} = Supuls.change_state_supul(state_supul)
    end
  end

  describe "national_supuls" do
    alias Demo.Supuls.NationalSupul

    @valid_attrs %{geographical_area: "some geographical_area", name: "some name"}
    @update_attrs %{geographical_area: "some updated geographical_area", name: "some updated name"}
    @invalid_attrs %{geographical_area: nil, name: nil}

    def national_supul_fixture(attrs \\ %{}) do
      {:ok, national_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Supuls.create_national_supul()

      national_supul
    end

    test "list_national_supuls/0 returns all national_supuls" do
      national_supul = national_supul_fixture()
      assert Supuls.list_national_supuls() == [national_supul]
    end

    test "get_national_supul!/1 returns the national_supul with given id" do
      national_supul = national_supul_fixture()
      assert Supuls.get_national_supul!(national_supul.id) == national_supul
    end

    test "create_national_supul/1 with valid data creates a national_supul" do
      assert {:ok, %NationalSupul{} = national_supul} = Supuls.create_national_supul(@valid_attrs)
      assert national_supul.geographical_area == "some geographical_area"
      assert national_supul.name == "some name"
    end

    test "create_national_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supuls.create_national_supul(@invalid_attrs)
    end

    test "update_national_supul/2 with valid data updates the national_supul" do
      national_supul = national_supul_fixture()
      assert {:ok, %NationalSupul{} = national_supul} = Supuls.update_national_supul(national_supul, @update_attrs)
      assert national_supul.geographical_area == "some updated geographical_area"
      assert national_supul.name == "some updated name"
    end

    test "update_national_supul/2 with invalid data returns error changeset" do
      national_supul = national_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = Supuls.update_national_supul(national_supul, @invalid_attrs)
      assert national_supul == Supuls.get_national_supul!(national_supul.id)
    end

    test "delete_national_supul/1 deletes the national_supul" do
      national_supul = national_supul_fixture()
      assert {:ok, %NationalSupul{}} = Supuls.delete_national_supul(national_supul)
      assert_raise Ecto.NoResultsError, fn -> Supuls.get_national_supul!(national_supul.id) end
    end

    test "change_national_supul/1 returns a national_supul changeset" do
      national_supul = national_supul_fixture()
      assert %Ecto.Changeset{} = Supuls.change_national_supul(national_supul)
    end
  end

  describe "continental_supuls" do
    alias Demo.Supuls.ContinentalSupul

    @valid_attrs %{geographical_area: "some geographical_area", name: "some name"}
    @update_attrs %{geographical_area: "some updated geographical_area", name: "some updated name"}
    @invalid_attrs %{geographical_area: nil, name: nil}

    def continental_supul_fixture(attrs \\ %{}) do
      {:ok, continental_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Supuls.create_continental_supul()

      continental_supul
    end

    test "list_continental_supuls/0 returns all continental_supuls" do
      continental_supul = continental_supul_fixture()
      assert Supuls.list_continental_supuls() == [continental_supul]
    end

    test "get_continental_supul!/1 returns the continental_supul with given id" do
      continental_supul = continental_supul_fixture()
      assert Supuls.get_continental_supul!(continental_supul.id) == continental_supul
    end

    test "create_continental_supul/1 with valid data creates a continental_supul" do
      assert {:ok, %ContinentalSupul{} = continental_supul} = Supuls.create_continental_supul(@valid_attrs)
      assert continental_supul.geographical_area == "some geographical_area"
      assert continental_supul.name == "some name"
    end

    test "create_continental_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Supuls.create_continental_supul(@invalid_attrs)
    end

    test "update_continental_supul/2 with valid data updates the continental_supul" do
      continental_supul = continental_supul_fixture()
      assert {:ok, %ContinentalSupul{} = continental_supul} = Supuls.update_continental_supul(continental_supul, @update_attrs)
      assert continental_supul.geographical_area == "some updated geographical_area"
      assert continental_supul.name == "some updated name"
    end

    test "update_continental_supul/2 with invalid data returns error changeset" do
      continental_supul = continental_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = Supuls.update_continental_supul(continental_supul, @invalid_attrs)
      assert continental_supul == Supuls.get_continental_supul!(continental_supul.id)
    end

    test "delete_continental_supul/1 deletes the continental_supul" do
      continental_supul = continental_supul_fixture()
      assert {:ok, %ContinentalSupul{}} = Supuls.delete_continental_supul(continental_supul)
      assert_raise Ecto.NoResultsError, fn -> Supuls.get_continental_supul!(continental_supul.id) end
    end

    test "change_continental_supul/1 returns a continental_supul changeset" do
      continental_supul = continental_supul_fixture()
      assert %Ecto.Changeset{} = Supuls.change_continental_supul(continental_supul)
    end
  end
end
