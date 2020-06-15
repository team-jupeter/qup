defmodule Demo.CampusTest do
  use Demo.DataCase

  alias Demo.Campus

  describe "schools" do
    alias Demo.Campus.School

    @valid_attrs %{description: "some description", mentors: "some mentors", title: "some title"}
    @update_attrs %{description: "some updated description", mentors: "some updated mentors", title: "some updated title"}
    @invalid_attrs %{description: nil, mentors: nil, title: nil}

    def school_fixture(attrs \\ %{}) do
      {:ok, school} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Campus.create_school()

      school
    end

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Campus.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Campus.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      assert {:ok, %School{} = school} = Campus.create_school(@valid_attrs)
      assert school.description == "some description"
      assert school.mentors == "some mentors"
      assert school.title == "some title"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Campus.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      assert {:ok, %School{} = school} = Campus.update_school(school, @update_attrs)
      assert school.description == "some updated description"
      assert school.mentors == "some updated mentors"
      assert school.title == "some updated title"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Campus.update_school(school, @invalid_attrs)
      assert school == Campus.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Campus.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Campus.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Campus.change_school(school)
    end
  end
end
