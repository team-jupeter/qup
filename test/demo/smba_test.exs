defmodule Demo.SMBATest do
  use Demo.DataCase

  alias Demo.SMBA

  describe "supports" do
    alias Demo.SMBA.Support

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def support_fixture(attrs \\ %{}) do
      {:ok, support} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SMBA.create_support()

      support
    end

    test "list_supports/0 returns all supports" do
      support = support_fixture()
      assert SMBA.list_supports() == [support]
    end

    test "get_support!/1 returns the support with given id" do
      support = support_fixture()
      assert SMBA.get_support!(support.id) == support
    end

    test "create_support/1 with valid data creates a support" do
      assert {:ok, %Support{} = support} = SMBA.create_support(@valid_attrs)
    end

    test "create_support/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SMBA.create_support(@invalid_attrs)
    end

    test "update_support/2 with valid data updates the support" do
      support = support_fixture()
      assert {:ok, %Support{} = support} = SMBA.update_support(support, @update_attrs)
    end

    test "update_support/2 with invalid data returns error changeset" do
      support = support_fixture()
      assert {:error, %Ecto.Changeset{}} = SMBA.update_support(support, @invalid_attrs)
      assert support == SMBA.get_support!(support.id)
    end

    test "delete_support/1 deletes the support" do
      support = support_fixture()
      assert {:ok, %Support{}} = SMBA.delete_support(support)
      assert_raise Ecto.NoResultsError, fn -> SMBA.get_support!(support.id) end
    end

    test "change_support/1 returns a support changeset" do
      support = support_fixture()
      assert %Ecto.Changeset{} = SMBA.change_support(support)
    end
  end
end
