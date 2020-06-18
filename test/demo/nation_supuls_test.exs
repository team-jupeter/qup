defmodule Demo.NationSupulsTest do
  use Demo.DataCase

  alias Demo.NationSupuls

  describe "nation_supuls" do
    alias Demo.NationSupuls.NationSupul

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def nation_supul_fixture(attrs \\ %{}) do
      {:ok, nation_supul} =
        attrs
        |> Enum.into(@valid_attrs)
        |> NationSupuls.create_nation_supul()

      nation_supul
    end

    test "list_nation_supuls/0 returns all nation_supuls" do
      nation_supul = nation_supul_fixture()
      assert NationSupuls.list_nation_supuls() == [nation_supul]
    end

    test "get_nation_supul!/1 returns the nation_supul with given id" do
      nation_supul = nation_supul_fixture()
      assert NationSupuls.get_nation_supul!(nation_supul.id) == nation_supul
    end

    test "create_nation_supul/1 with valid data creates a nation_supul" do
      assert {:ok, %NationSupul{} = nation_supul} = NationSupuls.create_nation_supul(@valid_attrs)
      assert nation_supul.name == "some name"
    end

    test "create_nation_supul/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NationSupuls.create_nation_supul(@invalid_attrs)
    end

    test "update_nation_supul/2 with valid data updates the nation_supul" do
      nation_supul = nation_supul_fixture()
      assert {:ok, %NationSupul{} = nation_supul} = NationSupuls.update_nation_supul(nation_supul, @update_attrs)
      assert nation_supul.name == "some updated name"
    end

    test "update_nation_supul/2 with invalid data returns error changeset" do
      nation_supul = nation_supul_fixture()
      assert {:error, %Ecto.Changeset{}} = NationSupuls.update_nation_supul(nation_supul, @invalid_attrs)
      assert nation_supul == NationSupuls.get_nation_supul!(nation_supul.id)
    end

    test "delete_nation_supul/1 deletes the nation_supul" do
      nation_supul = nation_supul_fixture()
      assert {:ok, %NationSupul{}} = NationSupuls.delete_nation_supul(nation_supul)
      assert_raise Ecto.NoResultsError, fn -> NationSupuls.get_nation_supul!(nation_supul.id) end
    end

    test "change_nation_supul/1 returns a nation_supul changeset" do
      nation_supul = nation_supul_fixture()
      assert %Ecto.Changeset{} = NationSupuls.change_nation_supul(nation_supul)
    end
  end
end
