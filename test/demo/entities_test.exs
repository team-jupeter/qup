defmodule Demo.EntitiesTest do
  use Demo.DataCase

  alias Demo.Companies

  describe "companies" do
    alias Demo.Companies.entity

    @valid_attrs %{category: "some category", name: "some name", reference: "some reference"}
    @update_attrs %{category: "some updated category", name: "some updated name", reference: "some updated reference"}
    @invalid_attrs %{category: nil, name: nil, reference: nil}

    def entity_fixture(attrs \\ %{}) do
      {:ok, entity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_entity()

      entity
    end

    test "list_companies/0 returns all companies" do
      entity = entity_fixture()
      assert Entities.list_companies() == [entity]
    end

    test "get_entity!/1 returns the entity with given id" do
      entity = entity_fixture()
      assert Entities.get_entity!(entity.id) == entity
    end

    test "create_entity/1 with valid data creates a entity" do
      assert {:ok, %Entity{} = entity} = Entities.create_entity(@valid_attrs)
      assert entity.category == "some category"
      assert entity.name == "some name"
      assert entity.reference == "some reference"
    end

    test "create_entity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_entity(@invalid_attrs)
    end

    test "update_entity/2 with valid data updates the entity" do
      entity = entity_fixture()
      assert {:ok, %Entity{} = entity} = Companies.update_entity(entity, @update_attrs)
      assert entity.category == "some updated category"
      assert entity.name == "some updated name"
      assert entity.reference == "some updated reference"
    end

    test "update_entity/2 with invalid data returns error changeset" do
      entity = entity_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_entity(entity, @invalid_attrs)
      assert entity == Entities.get_entity!(entity.id)
    end

    test "delete_entity/1 deletes the entity" do
      entity = entity_fixture()
      assert {:ok, %entity{}} = Entities.delete_entity(entity)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_entity!(entity.id) end
    end

    test "change_entity/1 returns a entity changeset" do
      entity = entity_fixture()
      assert %Ecto.Changeset{} = Entities.change_entity(entity)
    end
  end
end
