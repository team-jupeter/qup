defmodule Demo.FairTradesTest do
  use Demo.DataCase

  alias Demo.FairTrades

  describe "fair_trades" do
    alias Demo.FairTrades.FairTrade

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def fair_trade_fixture(attrs \\ %{}) do
      {:ok, fair_trade} =
        attrs
        |> Enum.into(@valid_attrs)
        |> FairTrades.create_fair_trade()

      fair_trade
    end

    test "list_fair_trades/0 returns all fair_trades" do
      fair_trade = fair_trade_fixture()
      assert FairTrades.list_fair_trades() == [fair_trade]
    end

    test "get_fair_trade!/1 returns the fair_trade with given id" do
      fair_trade = fair_trade_fixture()
      assert FairTrades.get_fair_trade!(fair_trade.id) == fair_trade
    end

    test "create_fair_trade/1 with valid data creates a fair_trade" do
      assert {:ok, %FairTrade{} = fair_trade} = FairTrades.create_fair_trade(@valid_attrs)
    end

    test "create_fair_trade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FairTrades.create_fair_trade(@invalid_attrs)
    end

    test "update_fair_trade/2 with valid data updates the fair_trade" do
      fair_trade = fair_trade_fixture()
      assert {:ok, %FairTrade{} = fair_trade} = FairTrades.update_fair_trade(fair_trade, @update_attrs)
    end

    test "update_fair_trade/2 with invalid data returns error changeset" do
      fair_trade = fair_trade_fixture()
      assert {:error, %Ecto.Changeset{}} = FairTrades.update_fair_trade(fair_trade, @invalid_attrs)
      assert fair_trade == FairTrades.get_fair_trade!(fair_trade.id)
    end

    test "delete_fair_trade/1 deletes the fair_trade" do
      fair_trade = fair_trade_fixture()
      assert {:ok, %FairTrade{}} = FairTrades.delete_fair_trade(fair_trade)
      assert_raise Ecto.NoResultsError, fn -> FairTrades.get_fair_trade!(fair_trade.id) end
    end

    test "change_fair_trade/1 returns a fair_trade changeset" do
      fair_trade = fair_trade_fixture()
      assert %Ecto.Changeset{} = FairTrades.change_fair_trade(fair_trade)
    end
  end
end
