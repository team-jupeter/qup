defmodule Demo.T3ListsTest do
  use Demo.DataCase

  alias Demo.T3Lists

  describe "t3_lists" do
    alias Demo.T3Lists.T3List

    @valid_attrs %{num_of_stocks: "some num_of_stocks", price_per_share: "some price_per_share"}
    @update_attrs %{num_of_stocks: "some updated num_of_stocks", price_per_share: "some updated price_per_share"}
    @invalid_attrs %{num_of_stocks: nil, price_per_share: nil}

    def t3_list_fixture(attrs \\ %{}) do
      {:ok, t3_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T3Lists.create_t3_list()

      t3_list
    end

    test "list_t3_lists/0 returns all t3_lists" do
      t3_list = t3_list_fixture()
      assert T3Lists.list_t3_lists() == [t3_list]
    end

    test "get_t3_list!/1 returns the t3_list with given id" do
      t3_list = t3_list_fixture()
      assert T3Lists.get_t3_list!(t3_list.id) == t3_list
    end

    test "create_t3_list/1 with valid data creates a t3_list" do
      assert {:ok, %T3List{} = t3_list} = T3Lists.create_t3_list(@valid_attrs)
      assert t3_list.num_of_stocks == "some num_of_stocks"
      assert t3_list.price_per_share == "some price_per_share"
    end

    test "create_t3_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T3Lists.create_t3_list(@invalid_attrs)
    end

    test "update_t3_list/2 with valid data updates the t3_list" do
      t3_list = t3_list_fixture()
      assert {:ok, %T3List{} = t3_list} = T3Lists.update_t3_list(t3_list, @update_attrs)
      assert t3_list.num_of_stocks == "some updated num_of_stocks"
      assert t3_list.price_per_share == "some updated price_per_share"
    end

    test "update_t3_list/2 with invalid data returns error changeset" do
      t3_list = t3_list_fixture()
      assert {:error, %Ecto.Changeset{}} = T3Lists.update_t3_list(t3_list, @invalid_attrs)
      assert t3_list == T3Lists.get_t3_list!(t3_list.id)
    end

    test "delete_t3_list/1 deletes the t3_list" do
      t3_list = t3_list_fixture()
      assert {:ok, %T3List{}} = T3Lists.delete_t3_list(t3_list)
      assert_raise Ecto.NoResultsError, fn -> T3Lists.get_t3_list!(t3_list.id) end
    end

    test "change_t3_list/1 returns a t3_list changeset" do
      t3_list = t3_list_fixture()
      assert %Ecto.Changeset{} = T3Lists.change_t3_list(t3_list)
    end
  end
end
