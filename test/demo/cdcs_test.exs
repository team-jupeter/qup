defmodule Demo.CDCSTest do
  use Demo.DataCase

  alias Demo.CDCS

  describe "cdcs" do
    alias Demo.CDCS.CDC

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def cdc_fixture(attrs \\ %{}) do
      {:ok, cdc} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CDCS.create_cdc()

      cdc
    end

    test "list_cdcs/0 returns all cdcs" do
      cdc = cdc_fixture()
      assert CDCS.list_cdcs() == [cdc]
    end

    test "get_cdc!/1 returns the cdc with given id" do
      cdc = cdc_fixture()
      assert CDCS.get_cdc!(cdc.id) == cdc
    end

    test "create_cdc/1 with valid data creates a cdc" do
      assert {:ok, %CDC{} = cdc} = CDCS.create_cdc(@valid_attrs)
    end

    test "create_cdc/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CDCS.create_cdc(@invalid_attrs)
    end

    test "update_cdc/2 with valid data updates the cdc" do
      cdc = cdc_fixture()
      assert {:ok, %CDC{} = cdc} = CDCS.update_cdc(cdc, @update_attrs)
    end

    test "update_cdc/2 with invalid data returns error changeset" do
      cdc = cdc_fixture()
      assert {:error, %Ecto.Changeset{}} = CDCS.update_cdc(cdc, @invalid_attrs)
      assert cdc == CDCS.get_cdc!(cdc.id)
    end

    test "delete_cdc/1 deletes the cdc" do
      cdc = cdc_fixture()
      assert {:ok, %CDC{}} = CDCS.delete_cdc(cdc)
      assert_raise Ecto.NoResultsError, fn -> CDCS.get_cdc!(cdc.id) end
    end

    test "change_cdc/1 returns a cdc changeset" do
      cdc = cdc_fixture()
      assert %Ecto.Changeset{} = CDCS.change_cdc(cdc)
    end
  end
end
