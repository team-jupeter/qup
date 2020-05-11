defmodule Demo.CashFlowsTest do
  use Demo.DataCase

  alias Demo.CashFlows

  describe "cash_flows" do
    alias Demo.CashFlows.CashFlow

    @valid_attrs %{capital_expenditures: "some capital_expenditures", changes_in_working_capital: "some changes_in_working_capital", debt_issuance: "some debt_issuance", depreciation_amortization: "some depreciation_amortization", equity_issuance: "some equity_issuance", net_earnings: "some net_earnings", opening_cash_balance: "some opening_cash_balance"}
    @update_attrs %{capital_expenditures: "some updated capital_expenditures", changes_in_working_capital: "some updated changes_in_working_capital", debt_issuance: "some updated debt_issuance", depreciation_amortization: "some updated depreciation_amortization", equity_issuance: "some updated equity_issuance", net_earnings: "some updated net_earnings", opening_cash_balance: "some updated opening_cash_balance"}
    @invalid_attrs %{capital_expenditures: nil, changes_in_working_capital: nil, debt_issuance: nil, depreciation_amortization: nil, equity_issuance: nil, net_earnings: nil, opening_cash_balance: nil}

    def cash_flow_fixture(attrs \\ %{}) do
      {:ok, cash_flow} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CashFlows.create_cash_flow()

      cash_flow
    end

    test "list_cash_flows/0 returns all cash_flows" do
      cash_flow = cash_flow_fixture()
      assert CashFlows.list_cash_flows() == [cash_flow]
    end

    test "get_cash_flow!/1 returns the cash_flow with given id" do
      cash_flow = cash_flow_fixture()
      assert CashFlows.get_cash_flow!(cash_flow.id) == cash_flow
    end

    test "create_cash_flow/1 with valid data creates a cash_flow" do
      assert {:ok, %CashFlow{} = cash_flow} = CashFlows.create_cash_flow(@valid_attrs)
      assert cash_flow.capital_expenditures == "some capital_expenditures"
      assert cash_flow.changes_in_working_capital == "some changes_in_working_capital"
      assert cash_flow.debt_issuance == "some debt_issuance"
      assert cash_flow.depreciation_amortization == "some depreciation_amortization"
      assert cash_flow.equity_issuance == "some equity_issuance"
      assert cash_flow.net_earnings == "some net_earnings"
      assert cash_flow.opening_cash_balance == "some opening_cash_balance"
    end

    test "create_cash_flow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CashFlows.create_cash_flow(@invalid_attrs)
    end

    test "update_cash_flow/2 with valid data updates the cash_flow" do
      cash_flow = cash_flow_fixture()
      assert {:ok, %CashFlow{} = cash_flow} = CashFlows.update_cash_flow(cash_flow, @update_attrs)
      assert cash_flow.capital_expenditures == "some updated capital_expenditures"
      assert cash_flow.changes_in_working_capital == "some updated changes_in_working_capital"
      assert cash_flow.debt_issuance == "some updated debt_issuance"
      assert cash_flow.depreciation_amortization == "some updated depreciation_amortization"
      assert cash_flow.equity_issuance == "some updated equity_issuance"
      assert cash_flow.net_earnings == "some updated net_earnings"
      assert cash_flow.opening_cash_balance == "some updated opening_cash_balance"
    end

    test "update_cash_flow/2 with invalid data returns error changeset" do
      cash_flow = cash_flow_fixture()
      assert {:error, %Ecto.Changeset{}} = CashFlows.update_cash_flow(cash_flow, @invalid_attrs)
      assert cash_flow == CashFlows.get_cash_flow!(cash_flow.id)
    end

    test "delete_cash_flow/1 deletes the cash_flow" do
      cash_flow = cash_flow_fixture()
      assert {:ok, %CashFlow{}} = CashFlows.delete_cash_flow(cash_flow)
      assert_raise Ecto.NoResultsError, fn -> CashFlows.get_cash_flow!(cash_flow.id) end
    end

    test "change_cash_flow/1 returns a cash_flow changeset" do
      cash_flow = cash_flow_fixture()
      assert %Ecto.Changeset{} = CashFlows.change_cash_flow(cash_flow)
    end
  end
end
