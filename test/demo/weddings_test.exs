defmodule Demo.WeddingsTest do
  use Demo.DataCase

  alias Demo.Weddings

  describe "weddings" do
    alias Demo.Weddings.Wedding

    @valid_attrs %{bride: "some bride", groom: "some groom"}
    @update_attrs %{bride: "some updated bride", groom: "some updated groom"}
    @invalid_attrs %{bride: nil, groom: nil}

    def wedding_fixture(attrs \\ %{}) do
      {:ok, wedding} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Weddings.create_wedding()

      wedding
    end

    test "list_weddings/0 returns all weddings" do
      wedding = wedding_fixture()
      assert Weddings.list_weddings() == [wedding]
    end

    test "get_wedding!/1 returns the wedding with given id" do
      wedding = wedding_fixture()
      assert Weddings.get_wedding!(wedding.id) == wedding
    end

    test "create_wedding/1 with valid data creates a wedding" do
      assert {:ok, %Wedding{} = wedding} = Weddings.create_wedding(@valid_attrs)
      assert wedding.bride == "some bride"
      assert wedding.groom == "some groom"
    end

    test "create_wedding/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weddings.create_wedding(@invalid_attrs)
    end

    test "update_wedding/2 with valid data updates the wedding" do
      wedding = wedding_fixture()
      assert {:ok, %Wedding{} = wedding} = Weddings.update_wedding(wedding, @update_attrs)
      assert wedding.bride == "some updated bride"
      assert wedding.groom == "some updated groom"
    end

    test "update_wedding/2 with invalid data returns error changeset" do
      wedding = wedding_fixture()
      assert {:error, %Ecto.Changeset{}} = Weddings.update_wedding(wedding, @invalid_attrs)
      assert wedding == Weddings.get_wedding!(wedding.id)
    end

    test "delete_wedding/1 deletes the wedding" do
      wedding = wedding_fixture()
      assert {:ok, %Wedding{}} = Weddings.delete_wedding(wedding)
      assert_raise Ecto.NoResultsError, fn -> Weddings.get_wedding!(wedding.id) end
    end

    test "change_wedding/1 returns a wedding changeset" do
      wedding = wedding_fixture()
      assert %Ecto.Changeset{} = Weddings.change_wedding(wedding)
    end
  end
end
