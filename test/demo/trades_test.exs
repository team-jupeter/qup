defmodule Demo.TradesTest do
  use Demo.DataCase

  alias Demo.Trades

  describe "invoice" do
    alias Demo.Trades.Trade

    @valid_attrs %{tax_authority: "some tax_authority"}
    @update_attrs %{tax_authority: "some updated tax_authority"}
    @invalid_attrs %{tax_authority: nil}

    def trade_fixture(attrs \\ %{}) do
      {:ok, trade} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trades.create_trade()

      trade
    end

    test "list_invoice/0 returns all invoice" do
      trade = trade_fixture()
      assert Trades.list_invoice() == [trade]
    end

    test "get_trade!/1 returns the trade with given id" do
      trade = trade_fixture()
      assert Trades.get_trade!(trade.id) == trade
    end

    test "create_trade/1 with valid data creates a trade" do
      assert {:ok, %Trade{} = trade} = Trades.create_trade(@valid_attrs)
      assert trade.tax_authority == "some tax_authority"
    end

    test "create_trade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trades.create_trade(@invalid_attrs)
    end

    test "update_trade/2 with valid data updates the trade" do
      trade = trade_fixture()
      assert {:ok, %Trade{} = trade} = Trades.update_trade(trade, @update_attrs)
      assert trade.tax_authority == "some updated tax_authority"
    end

    test "update_trade/2 with invalid data returns error changeset" do
      trade = trade_fixture()
      assert {:error, %Ecto.Changeset{}} = Trades.update_trade(trade, @invalid_attrs)
      assert trade == Trades.get_trade!(trade.id)
    end

    test "delete_trade/1 deletes the trade" do
      trade = trade_fixture()
      assert {:ok, %Trade{}} = Trades.delete_trade(trade)
      assert_raise Ecto.NoResultsError, fn -> Trades.get_trade!(trade.id) end
    end

    test "change_trade/1 returns a trade changeset" do
      trade = trade_fixture()
      assert %Ecto.Changeset{} = Trades.change_trade(trade)
    end
  end
end
