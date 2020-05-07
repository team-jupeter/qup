defmodule Demo.MofasTest do
  use Demo.DataCase

  alias Demo.Mofas

  describe "mofas" do
    alias Demo.Mofas.Mofa

    @valid_attrs %{address: "some address", ip: "some ip", name: "some name", nationality: "some nationality", tel: "some tel"}
    @update_attrs %{address: "some updated address", ip: "some updated ip", name: "some updated name", nationality: "some updated nationality", tel: "some updated tel"}
    @invalid_attrs %{address: nil, ip: nil, name: nil, nationality: nil, tel: nil}

    def mofa_fixture(attrs \\ %{}) do
      {:ok, mofa} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Mofas.create_mofa()

      mofa
    end

    test "list_mofas/0 returns all mofas" do
      mofa = mofa_fixture()
      assert Mofas.list_mofas() == [mofa]
    end

    test "get_mofa!/1 returns the mofa with given id" do
      mofa = mofa_fixture()
      assert Mofas.get_mofa!(mofa.id) == mofa
    end

    test "create_mofa/1 with valid data creates a mofa" do
      assert {:ok, %Mofa{} = mofa} = Mofas.create_mofa(@valid_attrs)
      assert mofa.address == "some address"
      assert mofa.ip == "some ip"
      assert mofa.name == "some name"
      assert mofa.nationality == "some nationality"
      assert mofa.tel == "some tel"
    end

    test "create_mofa/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mofas.create_mofa(@invalid_attrs)
    end

    test "update_mofa/2 with valid data updates the mofa" do
      mofa = mofa_fixture()
      assert {:ok, %Mofa{} = mofa} = Mofas.update_mofa(mofa, @update_attrs)
      assert mofa.address == "some updated address"
      assert mofa.ip == "some updated ip"
      assert mofa.name == "some updated name"
      assert mofa.nationality == "some updated nationality"
      assert mofa.tel == "some updated tel"
    end

    test "update_mofa/2 with invalid data returns error changeset" do
      mofa = mofa_fixture()
      assert {:error, %Ecto.Changeset{}} = Mofas.update_mofa(mofa, @invalid_attrs)
      assert mofa == Mofas.get_mofa!(mofa.id)
    end

    test "delete_mofa/1 deletes the mofa" do
      mofa = mofa_fixture()
      assert {:ok, %Mofa{}} = Mofas.delete_mofa(mofa)
      assert_raise Ecto.NoResultsError, fn -> Mofas.get_mofa!(mofa.id) end
    end

    test "change_mofa/1 returns a mofa changeset" do
      mofa = mofa_fixture()
      assert %Ecto.Changeset{} = Mofas.change_mofa(mofa)
    end
  end
end
