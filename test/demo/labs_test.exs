defmodule Demo.LabsTest do
  use Demo.DataCase

  alias Demo.Labs

  describe "name" do
    alias Demo.Labs.Lab

    @valid_attrs %{address: "some address", purpose: "some purpose"}
    @update_attrs %{address: "some updated address", purpose: "some updated purpose"}
    @invalid_attrs %{address: nil, purpose: nil}

    def lab_fixture(attrs \\ %{}) do
      {:ok, lab} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Labs.create_lab()

      lab
    end

    test "list_name/0 returns all name" do
      lab = lab_fixture()
      assert Labs.list_name() == [lab]
    end

    test "get_lab!/1 returns the lab with given id" do
      lab = lab_fixture()
      assert Labs.get_lab!(lab.id) == lab
    end

    test "create_lab/1 with valid data creates a lab" do
      assert {:ok, %Lab{} = lab} = Labs.create_lab(@valid_attrs)
      assert lab.address == "some address"
      assert lab.purpose == "some purpose"
    end

    test "create_lab/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Labs.create_lab(@invalid_attrs)
    end

    test "update_lab/2 with valid data updates the lab" do
      lab = lab_fixture()
      assert {:ok, %Lab{} = lab} = Labs.update_lab(lab, @update_attrs)
      assert lab.address == "some updated address"
      assert lab.purpose == "some updated purpose"
    end

    test "update_lab/2 with invalid data returns error changeset" do
      lab = lab_fixture()
      assert {:error, %Ecto.Changeset{}} = Labs.update_lab(lab, @invalid_attrs)
      assert lab == Labs.get_lab!(lab.id)
    end

    test "delete_lab/1 deletes the lab" do
      lab = lab_fixture()
      assert {:ok, %Lab{}} = Labs.delete_lab(lab)
      assert_raise Ecto.NoResultsError, fn -> Labs.get_lab!(lab.id) end
    end

    test "change_lab/1 returns a lab changeset" do
      lab = lab_fixture()
      assert %Ecto.Changeset{} = Labs.change_lab(lab)
    end
  end
end
