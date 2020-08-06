defmodule Demo.T3sTest do
  use Demo.DataCase

  alias Demo.T3s

  describe "t3s" do
    alias Demo.T3s.T3

    @valid_attrs %{book_price: "some book_price", current_owner: "some current_owner"}
    @update_attrs %{book_price: "some updated book_price", current_owner: "some updated current_owner"}
    @invalid_attrs %{book_price: nil, current_owner: nil}

    def t3_fixture(attrs \\ %{}) do
      {:ok, t3} =
        attrs
        |> Enum.into(@valid_attrs)
        |> T3s.create_t3()

      t3
    end

    test "list_t3s/0 returns all t3s" do
      t3 = t3_fixture()
      assert T3s.list_t3s() == [t3]
    end

    test "get_t3!/1 returns the t3 with given id" do
      t3 = t3_fixture()
      assert T3s.get_t3!(t3.id) == t3
    end

    test "create_t3/1 with valid data creates a t3" do
      assert {:ok, %T3{} = t3} = T3s.create_t3(@valid_attrs)
      assert t3.book_price == "some book_price"
      assert t3.current_owner == "some current_owner"
    end

    test "create_t3/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = T3s.create_t3(@invalid_attrs)
    end

    test "update_t3/2 with valid data updates the t3" do
      t3 = t3_fixture()
      assert {:ok, %T3{} = t3} = T3s.update_t3(t3, @update_attrs)
      assert t3.book_price == "some updated book_price"
      assert t3.current_owner == "some updated current_owner"
    end

    test "update_t3/2 with invalid data returns error changeset" do
      t3 = t3_fixture()
      assert {:error, %Ecto.Changeset{}} = T3s.update_t3(t3, @invalid_attrs)
      assert t3 == T3s.get_t3!(t3.id)
    end

    test "delete_t3/1 deletes the t3" do
      t3 = t3_fixture()
      assert {:ok, %T3{}} = T3s.delete_t3(t3)
      assert_raise Ecto.NoResultsError, fn -> T3s.get_t3!(t3.id) end
    end

    test "change_t3/1 returns a t3 changeset" do
      t3 = t3_fixture()
      assert %Ecto.Changeset{} = T3s.change_t3(t3)
    end
  end
end
