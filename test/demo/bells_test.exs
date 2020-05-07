defmodule Demo.BellsTest do
  use Demo.DataCase

  alias Demo.Bells

  describe "bells" do
    alias Demo.Bells.Bell

    @valid_attrs %{what: "some what", when: "some when", where: "some where", who: "some who", why: "some why"}
    @update_attrs %{what: "some updated what", when: "some updated when", where: "some updated where", who: "some updated who", why: "some updated why"}
    @invalid_attrs %{what: nil, when: nil, where: nil, who: nil, why: nil}

    def bell_fixture(attrs \\ %{}) do
      {:ok, bell} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bells.create_bell()

      bell
    end

    test "list_bells/0 returns all bells" do
      bell = bell_fixture()
      assert Bells.list_bells() == [bell]
    end

    test "get_bell!/1 returns the bell with given id" do
      bell = bell_fixture()
      assert Bells.get_bell!(bell.id) == bell
    end

    test "create_bell/1 with valid data creates a bell" do
      assert {:ok, %Bell{} = bell} = Bells.create_bell(@valid_attrs)
      assert bell.what == "some what"
      assert bell.when == "some when"
      assert bell.where == "some where"
      assert bell.who == "some who"
      assert bell.why == "some why"
    end

    test "create_bell/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bells.create_bell(@invalid_attrs)
    end

    test "update_bell/2 with valid data updates the bell" do
      bell = bell_fixture()
      assert {:ok, %Bell{} = bell} = Bells.update_bell(bell, @update_attrs)
      assert bell.what == "some updated what"
      assert bell.when == "some updated when"
      assert bell.where == "some updated where"
      assert bell.who == "some updated who"
      assert bell.why == "some updated why"
    end

    test "update_bell/2 with invalid data returns error changeset" do
      bell = bell_fixture()
      assert {:error, %Ecto.Changeset{}} = Bells.update_bell(bell, @invalid_attrs)
      assert bell == Bells.get_bell!(bell.id)
    end

    test "delete_bell/1 deletes the bell" do
      bell = bell_fixture()
      assert {:ok, %Bell{}} = Bells.delete_bell(bell)
      assert_raise Ecto.NoResultsError, fn -> Bells.get_bell!(bell.id) end
    end

    test "change_bell/1 returns a bell changeset" do
      bell = bell_fixture()
      assert %Ecto.Changeset{} = Bells.change_bell(bell)
    end
  end
end
