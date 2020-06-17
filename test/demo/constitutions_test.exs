defmodule Demo.ConstitutionsTest do
  use Demo.DataCase

  alias Demo.Constitutions

  describe "constitutions" do
    alias Demo.Constitutions.Constitution

    @valid_attrs %{hash: "some hash", private_key: "some private_key", text: "some text"}
    @update_attrs %{hash: "some updated hash", private_key: "some updated private_key", text: "some updated text"}
    @invalid_attrs %{hash: nil, private_key: nil, text: nil}

    def constitution_fixture(attrs \\ %{}) do
      {:ok, constitution} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Constitutions.create_constitution()

      constitution
    end

    test "list_constitutions/0 returns all constitutions" do
      constitution = constitution_fixture()
      assert Constitutions.list_constitutions() == [constitution]
    end

    test "get_constitution!/1 returns the constitution with given id" do
      constitution = constitution_fixture()
      assert Constitutions.get_constitution!(constitution.id) == constitution
    end

    test "create_constitution/1 with valid data creates a constitution" do
      assert {:ok, %Constitution{} = constitution} = Constitutions.create_constitution(@valid_attrs)
      assert constitution.hash == "some hash"
      assert constitution.private_key == "some private_key"
      assert constitution.text == "some text"
    end

    test "create_constitution/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Constitutions.create_constitution(@invalid_attrs)
    end

    test "update_constitution/2 with valid data updates the constitution" do
      constitution = constitution_fixture()
      assert {:ok, %Constitution{} = constitution} = Constitutions.update_constitution(constitution, @update_attrs)
      assert constitution.hash == "some updated hash"
      assert constitution.private_key == "some updated private_key"
      assert constitution.text == "some updated text"
    end

    test "update_constitution/2 with invalid data returns error changeset" do
      constitution = constitution_fixture()
      assert {:error, %Ecto.Changeset{}} = Constitutions.update_constitution(constitution, @invalid_attrs)
      assert constitution == Constitutions.get_constitution!(constitution.id)
    end

    test "delete_constitution/1 deletes the constitution" do
      constitution = constitution_fixture()
      assert {:ok, %Constitution{}} = Constitutions.delete_constitution(constitution)
      assert_raise Ecto.NoResultsError, fn -> Constitutions.get_constitution!(constitution.id) end
    end

    test "change_constitution/1 returns a constitution changeset" do
      constitution = constitution_fixture()
      assert %Ecto.Changeset{} = Constitutions.change_constitution(constitution)
    end
  end
end
