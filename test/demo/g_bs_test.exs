defmodule Demo.GBsTest do
  use Demo.DataCase

  alias Demo.GBs

  describe "gbs" do
    alias Demo.GBs.GB

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def gb_fixture(attrs \\ %{}) do
      {:ok, gb} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GBs.create_gb()

      gb
    end

    test "list_gbs/0 returns all gbs" do
      gb = gb_fixture()
      assert GBs.list_gbs() == [gb]
    end

    test "get_gb!/1 returns the gb with given id" do
      gb = gb_fixture()
      assert GBs.get_gb!(gb.id) == gb
    end

    test "create_gb/1 with valid data creates a gb" do
      assert {:ok, %GB{} = gb} = GBs.create_gb(@valid_attrs)
      assert gb.name == "some name"
    end

    test "create_gb/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GBs.create_gb(@invalid_attrs)
    end

    test "update_gb/2 with valid data updates the gb" do
      gb = gb_fixture()
      assert {:ok, %GB{} = gb} = GBs.update_gb(gb, @update_attrs)
      assert gb.name == "some updated name"
    end

    test "update_gb/2 with invalid data returns error changeset" do
      gb = gb_fixture()
      assert {:error, %Ecto.Changeset{}} = GBs.update_gb(gb, @invalid_attrs)
      assert gb == GBs.get_gb!(gb.id)
    end

    test "delete_gb/1 deletes the gb" do
      gb = gb_fixture()
      assert {:ok, %GB{}} = GBs.delete_gb(gb)
      assert_raise Ecto.NoResultsError, fn -> GBs.get_gb!(gb.id) end
    end

    test "change_gb/1 returns a gb changeset" do
      gb = gb_fixture()
      assert %Ecto.Changeset{} = GBs.change_gb(gb)
    end
  end
end
