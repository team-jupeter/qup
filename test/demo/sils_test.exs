defmodule Demo.SilsTest do
  use Demo.DataCase

  alias Demo.Sils

  describe "sils" do
    alias Demo.Sils.Sil

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def sil_fixture(attrs \\ %{}) do
      {:ok, sil} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sils.create_sil()

      sil
    end

    test "list_sils/0 returns all sils" do
      sil = sil_fixture()
      assert Sils.list_sils() == [sil]
    end

    test "get_sil!/1 returns the sil with given id" do
      sil = sil_fixture()
      assert Sils.get_sil!(sil.id) == sil
    end

    test "create_sil/1 with valid data creates a sil" do
      assert {:ok, %Sil{} = sil} = Sils.create_sil(@valid_attrs)
    end

    test "create_sil/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sils.create_sil(@invalid_attrs)
    end

    test "update_sil/2 with valid data updates the sil" do
      sil = sil_fixture()
      assert {:ok, %Sil{} = sil} = Sils.update_sil(sil, @update_attrs)
    end

    test "update_sil/2 with invalid data returns error changeset" do
      sil = sil_fixture()
      assert {:error, %Ecto.Changeset{}} = Sils.update_sil(sil, @invalid_attrs)
      assert sil == Sils.get_sil!(sil.id)
    end

    test "delete_sil/1 deletes the sil" do
      sil = sil_fixture()
      assert {:ok, %Sil{}} = Sils.delete_sil(sil)
      assert_raise Ecto.NoResultsError, fn -> Sils.get_sil!(sil.id) end
    end

    test "change_sil/1 returns a sil changeset" do
      sil = sil_fixture()
      assert %Ecto.Changeset{} = Sils.change_sil(sil)
    end
  end
end
