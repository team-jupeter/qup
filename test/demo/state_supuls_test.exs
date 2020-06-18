defmodule Demo.StateSupulsTest do
  use Demo.DataCase

  alias Demo.StateSupuls

  describe "state_supuls" do
    alias Demo.StateSupuls.StateSupul

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def state_supul_fixture(attrs \\ %{}) do
      {:ok, state_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> StateSupuls.create_state_supul()

      state_supul
    end

    test "list_state_supuls/0 returns all state_supuls" do
      state_supul = state_supul_fixture()
      assert StateSupuls.list_state_supuls() == [state_supul]
    end

    test "get_state_supul!/1 returns the state_supul with given id" do
      state_supul = state_supul_fixture()
      assert StateSupuls.get_state_supul!(state_supul.id) == state_supul
    end

    test "create_state_supul/1 with valid data creates a state_supul" do
      assert {:ok, %StateSupul{} = state_supul} = StateSupuls.create_state_supul(@valid_attrs)
      assert state_supul.name == "some name"
    end

    test "create_state_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StateSupuls.create_state_supul(@invalid_attrs)
    end

    test "update_state_supul/2 with valid data updates the state_supul" do
      state_supul = state_supul_fixture()
      assert {:ok, %StateSupul{} = state_supul} = StateSupuls.update_state_supul(state_supul, @update_attrs)
      assert state_supul.name == "some updated name"
    end

    test "update_state_supul/2 with invalid data returns error changeset" do
      state_supul = state_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = StateSupuls.update_state_supul(state_supul, @invalid_attrs)
      assert state_supul == StateSupuls.get_state_supul!(state_supul.id)
    end

    test "delete_state_supul/1 deletes the state_supul" do
      state_supul = state_supul_fixture()
      assert {:ok, %StateSupul{}} = StateSupuls.delete_state_supul(state_supul)
      assert_raise Ecto.NoResultsError, fn -> StateSupuls.get_state_supul!(state_supul.id) end
    end

    test "change_state_supul/1 returns a state_supul changeset" do
      state_supul = state_supul_fixture()
      assert %Ecto.Changeset{} = StateSupuls.change_state_supul(state_supul)
    end
  end
end
