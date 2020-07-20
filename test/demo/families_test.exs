defmodule Demo.FamiliesTest do
  use Demo.DataCase

  alias Demo.Families

  describe "members" do
    alias Demo.Families.Family

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def family_fixture(attrs \\ %{}) do
      {:ok, family} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Families.create_family()

      family
    end

    test "list_members/0 returns all members" do
      family = family_fixture()
      assert Families.list_members() == [family]
    end

    test "get_family!/1 returns the family with given id" do
      family = family_fixture()
      assert Families.get_family!(family.id) == family
    end

    test "create_family/1 with valid data creates a family" do
      assert {:ok, %Family{} = family} = Families.create_family(@valid_attrs)
    end

    test "create_family/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Families.create_family(@invalid_attrs)
    end

    test "update_family/2 with valid data updates the family" do
      family = family_fixture()
      assert {:ok, %Family{} = family} = Families.update_family(family, @update_attrs)
    end

    test "update_family/2 with invalid data returns error changeset" do
      family = family_fixture()
      assert {:error, %Ecto.Changeset{}} = Families.update_family(family, @invalid_attrs)
      assert family == Families.get_family!(family.id)
    end

    test "delete_family/1 deletes the family" do
      family = family_fixture()
      assert {:ok, %Family{}} = Families.delete_family(family)
      assert_raise Ecto.NoResultsError, fn -> Families.get_family!(family.id) end
    end

    test "change_family/1 returns a family changeset" do
      family = family_fixture()
      assert %Ecto.Changeset{} = Families.change_family(family)
    end
  end

  describe "families" do
    alias Demo.Families.Family

    @valid_attrs %{family_code: "some family_code"}
    @update_attrs %{family_code: "some updated family_code"}
    @invalid_attrs %{family_code: nil}

    def family_fixture(attrs \\ %{}) do
      {:ok, family} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Families.create_family()

      family
    end

    test "list_families/0 returns all families" do
      family = family_fixture()
      assert Families.list_families() == [family]
    end

    test "get_family!/1 returns the family with given id" do
      family = family_fixture()
      assert Families.get_family!(family.id) == family
    end

    test "create_family/1 with valid data creates a family" do
      assert {:ok, %Family{} = family} = Families.create_family(@valid_attrs)
      assert family.family_code == "some family_code"
    end

    test "create_family/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Families.create_family(@invalid_attrs)
    end

    test "update_family/2 with valid data updates the family" do
      family = family_fixture()
      assert {:ok, %Family{} = family} = Families.update_family(family, @update_attrs)
      assert family.family_code == "some updated family_code"
    end

    test "update_family/2 with invalid data returns error changeset" do
      family = family_fixture()
      assert {:error, %Ecto.Changeset{}} = Families.update_family(family, @invalid_attrs)
      assert family == Families.get_family!(family.id)
    end

    test "delete_family/1 deletes the family" do
      family = family_fixture()
      assert {:ok, %Family{}} = Families.delete_family(family)
      assert_raise Ecto.NoResultsError, fn -> Families.get_family!(family.id) end
    end

    test "change_family/1 returns a family changeset" do
      family = family_fixture()
      assert %Ecto.Changeset{} = Families.change_family(family)
    end
  end
end
