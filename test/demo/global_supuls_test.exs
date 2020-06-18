defmodule Demo.GlobalSupulsTest do
  use Demo.DataCase

  alias Demo.GlobalSupuls

  describe "global_supuls" do
    alias Demo.GlobalSupuls.GlobalSupul

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def global_supul_fixture(attrs \\ %{}) do
      {:ok, global_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GlobalSupuls.create_global_supul()

      global_supul
    end

    test "list_global_supuls/0 returns all global_supuls" do
      global_supul = global_supul_fixture()
      assert GlobalSupuls.list_global_supuls() == [global_supul]
    end

    test "get_global_supul!/1 returns the global_supul with given id" do
      global_supul = global_supul_fixture()
      assert GlobalSupuls.get_global_supul!(global_supul.id) == global_supul
    end

    test "create_global_supul/1 with valid data creates a global_supul" do
      assert {:ok, %GlobalSupul{} = global_supul} = GlobalSupuls.create_global_supul(@valid_attrs)
      assert global_supul.name == "some name"
    end

    test "create_global_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GlobalSupuls.create_global_supul(@invalid_attrs)
    end

    test "update_global_supul/2 with valid data updates the global_supul" do
      global_supul = global_supul_fixture()
      assert {:ok, %GlobalSupul{} = global_supul} = GlobalSupuls.update_global_supul(global_supul, @update_attrs)
      assert global_supul.name == "some updated name"
    end

    test "update_global_supul/2 with invalid data returns error changeset" do
      global_supul = global_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = GlobalSupuls.update_global_supul(global_supul, @invalid_attrs)
      assert global_supul == GlobalSupuls.get_global_supul!(global_supul.id)
    end

    test "delete_global_supul/1 deletes the global_supul" do
      global_supul = global_supul_fixture()
      assert {:ok, %GlobalSupul{}} = GlobalSupuls.delete_global_supul(global_supul)
      assert_raise Ecto.NoResultsError, fn -> GlobalSupuls.get_global_supul!(global_supul.id) end
    end

    test "change_global_supul/1 returns a global_supul changeset" do
      global_supul = global_supul_fixture()
      assert %Ecto.Changeset{} = GlobalSupuls.change_global_supul(global_supul)
    end
  end
end
