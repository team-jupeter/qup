defmodule Demo.T2ManagersTest do
  use Demo.DataCase

  alias Demo.T2Managers

  describe "t2_managers" do
    alias Demo.T2Managers.T2Manager

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def t2_manager_fixture(attrs \\ %{}) do
      {:ok, t2_manager} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T2Managers.create_t2_manager()

      t2_manager
    end

    test "list_t2_managers/0 returns all t2_managers" do
      t2_manager = t2_manager_fixture()
      assert T2Managers.list_t2_managers() == [t2_manager]
    end

    test "get_t2_manager!/1 returns the t2_manager with given id" do
      t2_manager = t2_manager_fixture()
      assert T2Managers.get_t2_manager!(t2_manager.id) == t2_manager
    end

    test "create_t2_manager/1 with valid data creates a t2_manager" do
      assert {:ok, %T2Manager{} = t2_manager} = T2Managers.create_t2_manager(@valid_attrs)
    end

    test "create_t2_manager/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T2Managers.create_t2_manager(@invalid_attrs)
    end

    test "update_t2_manager/2 with valid data updates the t2_manager" do
      t2_manager = t2_manager_fixture()
      assert {:ok, %T2Manager{} = t2_manager} = T2Managers.update_t2_manager(t2_manager, @update_attrs)
    end

    test "update_t2_manager/2 with invalid data returns error changeset" do
      t2_manager = t2_manager_fixture()
      assert {:error, %Ecto.Changeset{}} = T2Managers.update_t2_manager(t2_manager, @invalid_attrs)
      assert t2_manager == T2Managers.get_t2_manager!(t2_manager.id)
    end

    test "delete_t2_manager/1 deletes the t2_manager" do
      t2_manager = t2_manager_fixture()
      assert {:ok, %T2Manager{}} = T2Managers.delete_t2_manager(t2_manager)
      assert_raise Ecto.NoResultsError, fn -> T2Managers.get_t2_manager!(t2_manager.id) end
    end

    test "change_t2_manager/1 returns a t2_manager changeset" do
      t2_manager = t2_manager_fixture()
      assert %Ecto.Changeset{} = T2Managers.change_t2_manager(t2_manager)
    end
  end
end
