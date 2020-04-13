defmodule Demo.PolicesTest do
  use Demo.DataCase

  alias Demo.Polices

  describe "polices" do
    alias Demo.Polices.Police

    @valid_attrs %{name: "some name", nationality: "some nationality", wanted: "some wanted"}
    @update_attrs %{name: "some updated name", nationality: "some updated nationality", wanted: "some updated wanted"}
    @invalid_attrs %{name: nil, nationality: nil, wanted: nil}

    def police_fixture(attrs \\ %{}) do
      {:ok, police} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polices.create_police()

      police
    end

    test "list_polices/0 returns all polices" do
      police = police_fixture()
      assert Polices.list_polices() == [police]
    end

    test "get_police!/1 returns the police with given id" do
      police = police_fixture()
      assert Polices.get_police!(police.id) == police
    end

    test "create_police/1 with valid data creates a police" do
      assert {:ok, %Police{} = police} = Polices.create_police(@valid_attrs)
      assert police.name == "some name"
      assert police.nationality == "some nationality"
      assert police.wanted == "some wanted"
    end

    test "create_police/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polices.create_police(@invalid_attrs)
    end

    test "update_police/2 with valid data updates the police" do
      police = police_fixture()
      assert {:ok, %Police{} = police} = Polices.update_police(police, @update_attrs)
      assert police.name == "some updated name"
      assert police.nationality == "some updated nationality"
      assert police.wanted == "some updated wanted"
    end

    test "update_police/2 with invalid data returns error changeset" do
      police = police_fixture()
      assert {:error, %Ecto.Changeset{}} = Polices.update_police(police, @invalid_attrs)
      assert police == Polices.get_police!(police.id)
    end

    test "delete_police/1 deletes the police" do
      police = police_fixture()
      assert {:ok, %Police{}} = Polices.delete_police(police)
      assert_raise Ecto.NoResultsError, fn -> Polices.get_police!(police.id) end
    end

    test "change_police/1 returns a police changeset" do
      police = police_fixture()
      assert %Ecto.Changeset{} = Polices.change_police(police)
    end
  end
end
