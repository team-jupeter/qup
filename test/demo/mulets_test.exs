defmodule Demo.MuletsTest do
  use Demo.DataCase

  alias Demo.Mulets

  describe "sils" do
    alias Demo.Mulets.Sil

    @valid_attrs %{uid: "some uid"}
    @update_attrs %{uid: "some updated uid"}
    @invalid_attrs %{uid: nil}

    def sil_fixture(attrs \\ %{}) do
      {:ok, sil} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mulets.create_sil()

      sil
    end

    test "list_sils/0 returns all sils" do
      sil = sil_fixture()
      assert Mulets.list_sils() == [sil]
    end

    test "get_sil!/1 returns the sil with given id" do
      sil = sil_fixture()
      assert Mulets.get_sil!(sil.id) == sil
    end

    test "create_sil/1 with valid data creates a sil" do
      assert {:ok, %Sil{} = sil} = Mulets.create_sil(@valid_attrs)
      assert sil.uid == "some uid"
    end

    test "create_sil/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mulets.create_sil(@invalid_attrs)
    end

    test "update_sil/2 with valid data updates the sil" do
      sil = sil_fixture()
      assert {:ok, %Sil{} = sil} = Mulets.update_sil(sil, @update_attrs)
      assert sil.uid == "some updated uid"
    end

    test "update_sil/2 with invalid data returns error changeset" do
      sil = sil_fixture()
      assert {:error, %Ecto.Changeset{}} = Mulets.update_sil(sil, @invalid_attrs)
      assert sil == Mulets.get_sil!(sil.id)
    end

    test "delete_sil/1 deletes the sil" do
      sil = sil_fixture()
      assert {:ok, %Sil{}} = Mulets.delete_sil(sil)
      assert_raise Ecto.NoResultsError, fn -> Mulets.get_sil!(sil.id) end
    end

    test "change_sil/1 returns a sil changeset" do
      sil = sil_fixture()
      assert %Ecto.Changeset{} = Mulets.change_sil(sil)
    end
  end

  describe "mulets" do
    alias Demo.Mulets.Mulet

    @valid_attrs %{sil: "some sil"}
    @update_attrs %{sil: "some updated sil"}
    @invalid_attrs %{sil: nil}

    def mulet_fixture(attrs \\ %{}) do
      {:ok, mulet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mulets.create_mulet()

      mulet
    end

    test "list_mulets/0 returns all mulets" do
      mulet = mulet_fixture()
      assert Mulets.list_mulets() == [mulet]
    end

    test "get_mulet!/1 returns the mulet with given id" do
      mulet = mulet_fixture()
      assert Mulets.get_mulet!(mulet.id) == mulet
    end

    test "create_mulet/1 with valid data creates a mulet" do
      assert {:ok, %Mulet{} = mulet} = Mulets.create_mulet(@valid_attrs)
      assert mulet.sil == "some sil"
    end

    test "create_mulet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mulets.create_mulet(@invalid_attrs)
    end

    test "update_mulet/2 with valid data updates the mulet" do
      mulet = mulet_fixture()
      assert {:ok, %Mulet{} = mulet} = Mulets.update_mulet(mulet, @update_attrs)
      assert mulet.sil == "some updated sil"
    end

    test "update_mulet/2 with invalid data returns error changeset" do
      mulet = mulet_fixture()
      assert {:error, %Ecto.Changeset{}} = Mulets.update_mulet(mulet, @invalid_attrs)
      assert mulet == Mulets.get_mulet!(mulet.id)
    end

    test "delete_mulet/1 deletes the mulet" do
      mulet = mulet_fixture()
      assert {:ok, %Mulet{}} = Mulets.delete_mulet(mulet)
      assert_raise Ecto.NoResultsError, fn -> Mulets.get_mulet!(mulet.id) end
    end

    test "change_mulet/1 returns a mulet changeset" do
      mulet = mulet_fixture()
      assert %Ecto.Changeset{} = Mulets.change_mulet(mulet)
    end
  end

  describe "mulets" do
    alias Demo.Mulets.Mulet

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def mulet_fixture(attrs \\ %{}) do
      {:ok, mulet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mulets.create_mulet()

      mulet
    end

    test "list_mulets/0 returns all mulets" do
      mulet = mulet_fixture()
      assert Mulets.list_mulets() == [mulet]
    end

    test "get_mulet!/1 returns the mulet with given id" do
      mulet = mulet_fixture()
      assert Mulets.get_mulet!(mulet.id) == mulet
    end

    test "create_mulet/1 with valid data creates a mulet" do
      assert {:ok, %Mulet{} = mulet} = Mulets.create_mulet(@valid_attrs)
    end

    test "create_mulet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mulets.create_mulet(@invalid_attrs)
    end

    test "update_mulet/2 with valid data updates the mulet" do
      mulet = mulet_fixture()
      assert {:ok, %Mulet{} = mulet} = Mulets.update_mulet(mulet, @update_attrs)
    end

    test "update_mulet/2 with invalid data returns error changeset" do
      mulet = mulet_fixture()
      assert {:error, %Ecto.Changeset{}} = Mulets.update_mulet(mulet, @invalid_attrs)
      assert mulet == Mulets.get_mulet!(mulet.id)
    end

    test "delete_mulet/1 deletes the mulet" do
      mulet = mulet_fixture()
      assert {:ok, %Mulet{}} = Mulets.delete_mulet(mulet)
      assert_raise Ecto.NoResultsError, fn -> Mulets.get_mulet!(mulet.id) end
    end

    test "change_mulet/1 returns a mulet changeset" do
      mulet = mulet_fixture()
      assert %Ecto.Changeset{} = Mulets.change_mulet(mulet)
    end
  end
end
