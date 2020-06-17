defmodule Demo.TicsTest do
  use Demo.DataCase

  alias Demo.Tics

  describe "tics" do
    alias Demo.Tics.Tic

    @valid_attrs %{datetime: ~N[2010-04-17 14:00:00]}
    @update_attrs %{datetime: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{datetime: nil}

    def tic_fixture(attrs \\ %{}) do
      {:ok, tic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tics.create_tic()

      tic
    end

    test "list_tics/0 returns all tics" do
      tic = tic_fixture()
      assert Tics.list_tics() == [tic]
    end

    test "get_tic!/1 returns the tic with given id" do
      tic = tic_fixture()
      assert Tics.get_tic!(tic.id) == tic
    end

    test "create_tic/1 with valid data creates a tic" do
      assert {:ok, %Tic{} = tic} = Tics.create_tic(@valid_attrs)
      assert tic.datetime == ~N[2010-04-17 14:00:00]
    end

    test "create_tic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tics.create_tic(@invalid_attrs)
    end

    test "update_tic/2 with valid data updates the tic" do
      tic = tic_fixture()
      assert {:ok, %Tic{} = tic} = Tics.update_tic(tic, @update_attrs)
      assert tic.datetime == ~N[2011-05-18 15:01:01]
    end

    test "update_tic/2 with invalid data returns error changeset" do
      tic = tic_fixture()
      assert {:error, %Ecto.Changeset{}} = Tics.update_tic(tic, @invalid_attrs)
      assert tic == Tics.get_tic!(tic.id)
    end

    test "delete_tic/1 deletes the tic" do
      tic = tic_fixture()
      assert {:ok, %Tic{}} = Tics.delete_tic(tic)
      assert_raise Ecto.NoResultsError, fn -> Tics.get_tic!(tic.id) end
    end

    test "change_tic/1 returns a tic changeset" do
      tic = tic_fixture()
      assert %Ecto.Changeset{} = Tics.change_tic(tic)
    end
  end
end
