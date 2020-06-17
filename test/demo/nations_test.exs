defmodule Demo.NationsTest do
  use Demo.DataCase

  alias Demo.Nations

  describe "nations" do
    alias Demo.Nations.Nation

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def nation_fixture(attrs \\ %{}) do
      {:ok, nation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Nations.create_nation()

      nation
    end

    test "list_nations/0 returns all nations" do
      nation = nation_fixture()
      assert Nations.list_nations() == [nation]
    end

    test "get_nation!/1 returns the nation with given id" do
      nation = nation_fixture()
      assert Nations.get_nation!(nation.id) == nation
    end

    test "create_nation/1 with valid data creates a nation" do
      assert {:ok, %Nation{} = nation} = Nations.create_nation(@valid_attrs)
      assert nation.name == "some name"
    end

    test "create_nation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Nations.create_nation(@invalid_attrs)
    end

    test "update_nation/2 with valid data updates the nation" do
      nation = nation_fixture()
      assert {:ok, %Nation{} = nation} = Nations.update_nation(nation, @update_attrs)
      assert nation.name == "some updated name"
    end

    test "update_nation/2 with invalid data returns error changeset" do
      nation = nation_fixture()
      assert {:error, %Ecto.Changeset{}} = Nations.update_nation(nation, @invalid_attrs)
      assert nation == Nations.get_nation!(nation.id)
    end

    test "delete_nation/1 deletes the nation" do
      nation = nation_fixture()
      assert {:ok, %Nation{}} = Nations.delete_nation(nation)
      assert_raise Ecto.NoResultsError, fn -> Nations.get_nation!(nation.id) end
    end

    test "change_nation/1 returns a nation changeset" do
      nation = nation_fixture()
      assert %Ecto.Changeset{} = Nations.change_nation(nation)
    end
  end
end
