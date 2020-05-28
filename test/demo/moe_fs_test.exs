defmodule Demo.MOEFsTest do

  alias Demo.MOEFs

  describe "moefs" do
    alias Demo.MOEFs.MOEF

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def moef_fixture(attrs \\ %{}) do
      {:ok, moef} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MOEFs.create_moef()

      moef
    end

    test "list_moefs/0 returns all moefs" do
      moef = moef_fixture()
      assert MOEFs.list_moefs() == [moef]
    end

    test "get_moef!/1 returns the moef with given id" do
      moef = moef_fixture()
      assert MOEFs.get_moef!(moef.id) == moef
    end

    test "create_moef/1 with valid data creates a moef" do
      assert {:ok, %MOEF{} = moef} = MOEFs.create_moef(@valid_attrs)
    end

    test "create_moef/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MOEFs.create_moef(@invalid_attrs)
    end

    test "update_moef/2 with valid data updates the moef" do
      moef = moef_fixture()
      assert {:ok, %MOEF{} = moef} = MOEFs.update_moef(moef, @update_attrs)
    end

    test "update_moef/2 with invalid data returns error changeset" do
      moef = moef_fixture()
      assert {:error, %Ecto.Changeset{}} = MOEFs.update_moef(moef, @invalid_attrs)
      assert moef == MOEFs.get_moef!(moef.id)
    end

    test "delete_moef/1 deletes the moef" do
      moef = moef_fixture()
      assert {:ok, %MOEF{}} = MOEFs.delete_moef(moef)
      assert_raise Ecto.NoResultsError, fn -> MOEFs.get_moef!(moef.id) end
    end

    test "change_moef/1 returns a moef changeset" do
      moef = moef_fixture()
      assert %Ecto.Changeset{} = MOEFs.change_moef(moef)
    end
  end
end
