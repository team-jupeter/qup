defmodule Demo.SphonesTest do
  use Demo.DataCase

  alias Demo.Sphones

  describe "sphones" do
    alias Demo.Sphones.Sphone

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def sphone_fixture(attrs \\ %{}) do
      {:ok, sphone} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sphones.create_sphone()

      sphone
    end

    test "list_sphones/0 returns all sphones" do
      sphone = sphone_fixture()
      assert Sphones.list_sphones() == [sphone]
    end

    test "get_sphone!/1 returns the sphone with given id" do
      sphone = sphone_fixture()
      assert Sphones.get_sphone!(sphone.id) == sphone
    end

    test "create_sphone/1 with valid data creates a sphone" do
      assert {:ok, %Sphone{} = sphone} = Sphones.create_sphone(@valid_attrs)
      assert sphone.name == "some name"
    end

    test "create_sphone/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sphones.create_sphone(@invalid_attrs)
    end

    test "update_sphone/2 with valid data updates the sphone" do
      sphone = sphone_fixture()
      assert {:ok, %Sphone{} = sphone} = Sphones.update_sphone(sphone, @update_attrs)
      assert sphone.name == "some updated name"
    end

    test "update_sphone/2 with invalid data returns error changeset" do
      sphone = sphone_fixture()
      assert {:error, %Ecto.Changeset{}} = Sphones.update_sphone(sphone, @invalid_attrs)
      assert sphone == Sphones.get_sphone!(sphone.id)
    end

    test "delete_sphone/1 deletes the sphone" do
      sphone = sphone_fixture()
      assert {:ok, %Sphone{}} = Sphones.delete_sphone(sphone)
      assert_raise Ecto.NoResultsError, fn -> Sphones.get_sphone!(sphone.id) end
    end

    test "change_sphone/1 returns a sphone changeset" do
      sphone = sphone_fixture()
      assert %Ecto.Changeset{} = Sphones.change_sphone(sphone)
    end
  end
end
