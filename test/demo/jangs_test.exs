defmodule Demo.JangsTest do
  use Demo.DataCase

  alias Demo.Jangs

  describe "jangs" do
    alias Demo.Jangs.Jang

    @valid_attrs %{cart: "some cart"}
    @update_attrs %{cart: "some updated cart"}
    @invalid_attrs %{cart: nil}

    def jang_fixture(attrs \\ %{}) do
      {:ok, jang} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Jangs.create_jang()

      jang
    end

    test "list_jangs/0 returns all jangs" do
      jang = jang_fixture()
      assert Jangs.list_jangs() == [jang]
    end

    test "get_jang!/1 returns the jang with given id" do
      jang = jang_fixture()
      assert Jangs.get_jang!(jang.id) == jang
    end

    test "create_jang/1 with valid data creates a jang" do
      assert {:ok, %Jang{} = jang} = Jangs.create_jang(@valid_attrs)
      assert jang.cart == "some cart"
    end

    test "create_jang/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jangs.create_jang(@invalid_attrs)
    end

    test "update_jang/2 with valid data updates the jang" do
      jang = jang_fixture()
      assert {:ok, %Jang{} = jang} = Jangs.update_jang(jang, @update_attrs)
      assert jang.cart == "some updated cart"
    end

    test "update_jang/2 with invalid data returns error changeset" do
      jang = jang_fixture()
      assert {:error, %Ecto.Changeset{}} = Jangs.update_jang(jang, @invalid_attrs)
      assert jang == Jangs.get_jang!(jang.id)
    end

    test "delete_jang/1 deletes the jang" do
      jang = jang_fixture()
      assert {:ok, %Jang{}} = Jangs.delete_jang(jang)
      assert_raise Ecto.NoResultsError, fn -> Jangs.get_jang!(jang.id) end
    end

    test "change_jang/1 returns a jang changeset" do
      jang = jang_fixture()
      assert %Ecto.Changeset{} = Jangs.change_jang(jang)
    end
  end
end
