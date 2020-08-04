defmodule Demo.GABsTest do
  use Demo.DataCase

  alias Demo.GABs

  describe "gabs" do
    alias Demo.GABs.GAB

    @valid_attrs %{nationality: "some nationality"}
    @update_attrs %{nationality: "some updated nationality"}
    @invalid_attrs %{nationality: nil}

    def gab_fixture(attrs \\ %{}) do
      {:ok, gab} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GABs.create_gab()

      gab
    end

    test "list_gabs/0 returns all gabs" do
      gab = gab_fixture()
      assert GABs.list_gabs() == [gab]
    end

    test "get_gab!/1 returns the gab with given id" do
      gab = gab_fixture()
      assert GABs.get_gab!(gab.id) == gab
    end

    test "create_gab/1 with valid data creates a gab" do
      assert {:ok, %GAB{} = gab} = GABs.create_gab(@valid_attrs)
      assert gab.nationality == "some nationality"
    end

    test "create_gab/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GABs.create_gab(@invalid_attrs)
    end

    test "update_gab/2 with valid data updates the gab" do
      gab = gab_fixture()
      assert {:ok, %GAB{} = gab} = GABs.update_gab(gab, @update_attrs)
      assert gab.nationality == "some updated nationality"
    end

    test "update_gab/2 with invalid data returns error changeset" do
      gab = gab_fixture()
      assert {:error, %Ecto.Changeset{}} = GABs.update_gab(gab, @invalid_attrs)
      assert gab == GABs.get_gab!(gab.id)
    end

    test "delete_gab/1 deletes the gab" do
      gab = gab_fixture()
      assert {:ok, %GAB{}} = GABs.delete_gab(gab)
      assert_raise Ecto.NoResultsError, fn -> GABs.get_gab!(gab.id) end
    end

    test "change_gab/1 returns a gab changeset" do
      gab = gab_fixture()
      assert %Ecto.Changeset{} = GABs.change_gab(gab)
    end
  end
end
