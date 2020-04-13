defmodule Demo.BanksTest do
  use Demo.DataCase

  alias Demo.Banks

  describe "banks" do
    alias Demo.Banks.Bank

    @valid_attrs %{name: "some name", nationality: "some nationality"}
    @update_attrs %{name: "some updated name", nationality: "some updated nationality"}
    @invalid_attrs %{name: nil, nationality: nil}

    def bank_fixture(attrs \\ %{}) do
      {:ok, bank} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banks.create_bank()

      bank
    end

    test "list_banks/0 returns all banks" do
      bank = bank_fixture()
      assert Banks.list_banks() == [bank]
    end

    test "get_bank!/1 returns the bank with given id" do
      bank = bank_fixture()
      assert Banks.get_bank!(bank.id) == bank
    end

    test "create_bank/1 with valid data creates a bank" do
      assert {:ok, %Bank{} = bank} = Banks.create_bank(@valid_attrs)
      assert bank.name == "some name"
      assert bank.nationality == "some nationality"
    end

    test "create_bank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banks.create_bank(@invalid_attrs)
    end

    test "update_bank/2 with valid data updates the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{} = bank} = Banks.update_bank(bank, @update_attrs)
      assert bank.name == "some updated name"
      assert bank.nationality == "some updated nationality"
    end

    test "update_bank/2 with invalid data returns error changeset" do
      bank = bank_fixture()
      assert {:error, %Ecto.Changeset{}} = Banks.update_bank(bank, @invalid_attrs)
      assert bank == Banks.get_bank!(bank.id)
    end

    test "delete_bank/1 deletes the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{}} = Banks.delete_bank(bank)
      assert_raise Ecto.NoResultsError, fn -> Banks.get_bank!(bank.id) end
    end

    test "change_bank/1 returns a bank changeset" do
      bank = bank_fixture()
      assert %Ecto.Changeset{} = Banks.change_bank(bank)
    end
  end
end
