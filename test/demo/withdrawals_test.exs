defmodule Demo.WithdrawalsTest do
  use Demo.DataCase

  alias Demo.Withdrawals

  describe "withdrawals" do
    alias Demo.Withdrawals.Withdrawal

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def withdrawal_fixture(attrs \\ %{}) do
      {:ok, withdrawal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Withdrawals.create_withdrawal()

      withdrawal
    end

    test "list_withdrawals/0 returns all withdrawals" do
      withdrawal = withdrawal_fixture()
      assert Withdrawals.list_withdrawals() == [withdrawal]
    end

    test "get_withdrawal!/1 returns the withdrawal with given id" do
      withdrawal = withdrawal_fixture()
      assert Withdrawals.get_withdrawal!(withdrawal.id) == withdrawal
    end

    test "create_withdrawal/1 with valid data creates a withdrawal" do
      assert {:ok, %Withdrawal{} = withdrawal} = Withdrawals.create_withdrawal(@valid_attrs)
    end

    test "create_withdrawal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Withdrawals.create_withdrawal(@invalid_attrs)
    end

    test "update_withdrawal/2 with valid data updates the withdrawal" do
      withdrawal = withdrawal_fixture()
      assert {:ok, %Withdrawal{} = withdrawal} = Withdrawals.update_withdrawal(withdrawal, @update_attrs)
    end

    test "update_withdrawal/2 with invalid data returns error changeset" do
      withdrawal = withdrawal_fixture()
      assert {:error, %Ecto.Changeset{}} = Withdrawals.update_withdrawal(withdrawal, @invalid_attrs)
      assert withdrawal == Withdrawals.get_withdrawal!(withdrawal.id)
    end

    test "delete_withdrawal/1 deletes the withdrawal" do
      withdrawal = withdrawal_fixture()
      assert {:ok, %Withdrawal{}} = Withdrawals.delete_withdrawal(withdrawal)
      assert_raise Ecto.NoResultsError, fn -> Withdrawals.get_withdrawal!(withdrawal.id) end
    end

    test "change_withdrawal/1 returns a withdrawal changeset" do
      withdrawal = withdrawal_fixture()
      assert %Ecto.Changeset{} = Withdrawals.change_withdrawal(withdrawal)
    end
  end
end
