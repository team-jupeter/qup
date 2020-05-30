defmodule Demo.GopangsTest do
  use Demo.DataCase

  alias Demo.Gopangs

  describe "gopangs" do
    alias Demo.Gopangs.Gopang

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def gopang_fixture(attrs \\ %{}) do
      {:ok, gopang} =
        attrs
        |> Enum.into(@valid_attrs)
        |> gopangs.create_gopang()

      gopang
    end

    test "list_gopangs/0 returns all gopangs" do
      gopang = gopang_fixture()
      assert gopangs.list_gopangs() == [gopang]
    end

    test "get_gopang!/1 returns the gopang with given id" do
      gopang = gopang_fixture()
      assert gopangs.get_gopang!(gopang.id) == gopang
    end

    test "create_gopang/1 with valid data creates a gopang" do
      assert {:ok, %Gopang{} = gopang} = gopangs.create_gopang(@valid_attrs)
    end

    test "create_gopang/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = gopangs.create_gopang(@invalid_attrs)
    end

    test "update_gopang/2 with valid data updates the gopang" do
      gopang = gopang_fixture()
      assert {:ok, %Gopang{} = gopang} = gopangs.update_gopang(gopang, @update_attrs)
    end

    test "update_gopang/2 with invalid data returns error changeset" do
      gopang = gopang_fixture()
      assert {:error, %Ecto.Changeset{}} = gopangs.update_gopang(gopang, @invalid_attrs)
      assert gopang == gopangs.get_gopang!(gopang.id)
    end

    test "delete_gopang/1 deletes the gopang" do
      gopang = gopang_fixture()
      assert {:ok, %Gopang{}} = gopangs.delete_gopang(gopang)
      assert_raise Ecto.NoResultsError, fn -> gopangs.get_gopang!(gopang.id) end
    end

    test "change_gopang/1 returns a gopang changeset" do
      gopang = gopang_fixture()
      assert %Ecto.Changeset{} = gopangs.change_gopang(gopang)
    end
  end
end
