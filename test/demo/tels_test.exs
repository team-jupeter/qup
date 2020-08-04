defmodule Demo.TelsTest do
  use Demo.DataCase

  alias Demo.Tels

  describe "tels" do
    alias Demo.Tels.Tel

    @valid_attrs %{number: 42}
    @update_attrs %{number: 43}
    @invalid_attrs %{number: nil}

    def tel_fixture(attrs \\ %{}) do
      {:ok, tel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tels.create_tel()

      tel
    end

    test "list_tels/0 returns all tels" do
      tel = tel_fixture()
      assert Tels.list_tels() == [tel]
    end

    test "get_tel!/1 returns the tel with given id" do
      tel = tel_fixture()
      assert Tels.get_tel!(tel.id) == tel
    end

    test "create_tel/1 with valid data creates a tel" do
      assert {:ok, %Tel{} = tel} = Tels.create_tel(@valid_attrs)
      assert tel.number == 42
    end

    test "create_tel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tels.create_tel(@invalid_attrs)
    end

    test "update_tel/2 with valid data updates the tel" do
      tel = tel_fixture()
      assert {:ok, %Tel{} = tel} = Tels.update_tel(tel, @update_attrs)
      assert tel.number == 43
    end

    test "update_tel/2 with invalid data returns error changeset" do
      tel = tel_fixture()
      assert {:error, %Ecto.Changeset{}} = Tels.update_tel(tel, @invalid_attrs)
      assert tel == Tels.get_tel!(tel.id)
    end

    test "delete_tel/1 deletes the tel" do
      tel = tel_fixture()
      assert {:ok, %Tel{}} = Tels.delete_tel(tel)
      assert_raise Ecto.NoResultsError, fn -> Tels.get_tel!(tel.id) end
    end

    test "change_tel/1 returns a tel changeset" do
      tel = tel_fixture()
      assert %Ecto.Changeset{} = Tels.change_tel(tel)
    end
  end
end
