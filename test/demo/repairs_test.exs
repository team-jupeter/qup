defmodule Demo.RepairsTest do
  use Demo.DataCase

  alias Demo.Repairs

  describe "income_statements" do
    alias Demo.Repairs.IncomeStatement

    @valid_attrs %{compensation: "some compensation", cost_of_goods_sold: "some cost_of_goods_sold", depreciation_and_amortization: "some depreciation_and_amortization", employee_benefits: "some employee_benefits", income_taxes: "some income_taxes", insurance: "some insurance", marketing: "some marketing", office: "some office", payroll: "some payroll", professional_fees: "some professional_fees", rent: "some rent", repair_and_maintenance: "some repair_and_maintenance", revenue: "some revenue", sales_discounts: "some sales_discounts", supplies: "some supplies", taxes: "some taxes", travel_and_entertainment: "some travel_and_entertainment", utilities: "some utilities"}
    @update_attrs %{compensation: "some updated compensation", cost_of_goods_sold: "some updated cost_of_goods_sold", depreciation_and_amortization: "some updated depreciation_and_amortization", employee_benefits: "some updated employee_benefits", income_taxes: "some updated income_taxes", insurance: "some updated insurance", marketing: "some updated marketing", office: "some updated office", payroll: "some updated payroll", professional_fees: "some updated professional_fees", rent: "some updated rent", repair_and_maintenance: "some updated repair_and_maintenance", revenue: "some updated revenue", sales_discounts: "some updated sales_discounts", supplies: "some updated supplies", taxes: "some updated taxes", travel_and_entertainment: "some updated travel_and_entertainment", utilities: "some updated utilities"}
    @invalid_attrs %{compensation: nil, cost_of_goods_sold: nil, depreciation_and_amortization: nil, employee_benefits: nil, income_taxes: nil, insurance: nil, marketing: nil, office: nil, payroll: nil, professional_fees: nil, rent: nil, repair_and_maintenance: nil, revenue: nil, sales_discounts: nil, supplies: nil, taxes: nil, travel_and_entertainment: nil, utilities: nil}

    def income_statement_fixture(attrs \\ %{}) do
      {:ok, income_statement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Repairs.create_income_statement()

      income_statement
    end

    test "list_income_statements/0 returns all income_statements" do
      income_statement = income_statement_fixture()
      assert Repairs.list_income_statements() == [income_statement]
    end

    test "get_income_statement!/1 returns the income_statement with given id" do
      income_statement = income_statement_fixture()
      assert Repairs.get_income_statement!(income_statement.id) == income_statement
    end

    test "create_income_statement/1 with valid data creates a income_statement" do
      assert {:ok, %IncomeStatement{} = income_statement} = Repairs.create_income_statement(@valid_attrs)
      assert income_statement.compensation == "some compensation"
      assert income_statement.cost_of_goods_sold == "some cost_of_goods_sold"
      assert income_statement.depreciation_and_amortization == "some depreciation_and_amortization"
      assert income_statement.employee_benefits == "some employee_benefits"
      assert income_statement.income_taxes == "some income_taxes"
      assert income_statement.insurance == "some insurance"
      assert income_statement.marketing == "some marketing"
      assert income_statement.office == "some office"
      assert income_statement.payroll == "some payroll"
      assert income_statement.professional_fees == "some professional_fees"
      assert income_statement.rent == "some rent"
      assert income_statement.repair_and_maintenance == "some repair_and_maintenance"
      assert income_statement.revenue == "some revenue"
      assert income_statement.sales_discounts == "some sales_discounts"
      assert income_statement.supplies == "some supplies"
      assert income_statement.taxes == "some taxes"
      assert income_statement.travel_and_entertainment == "some travel_and_entertainment"
      assert income_statement.utilities == "some utilities"
    end

    test "create_income_statement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Repairs.create_income_statement(@invalid_attrs)
    end

    test "update_income_statement/2 with valid data updates the income_statement" do
      income_statement = income_statement_fixture()
      assert {:ok, %IncomeStatement{} = income_statement} = Repairs.update_income_statement(income_statement, @update_attrs)
      assert income_statement.compensation == "some updated compensation"
      assert income_statement.cost_of_goods_sold == "some updated cost_of_goods_sold"
      assert income_statement.depreciation_and_amortization == "some updated depreciation_and_amortization"
      assert income_statement.employee_benefits == "some updated employee_benefits"
      assert income_statement.income_taxes == "some updated income_taxes"
      assert income_statement.insurance == "some updated insurance"
      assert income_statement.marketing == "some updated marketing"
      assert income_statement.office == "some updated office"
      assert income_statement.payroll == "some updated payroll"
      assert income_statement.professional_fees == "some updated professional_fees"
      assert income_statement.rent == "some updated rent"
      assert income_statement.repair_and_maintenance == "some updated repair_and_maintenance"
      assert income_statement.revenue == "some updated revenue"
      assert income_statement.sales_discounts == "some updated sales_discounts"
      assert income_statement.supplies == "some updated supplies"
      assert income_statement.taxes == "some updated taxes"
      assert income_statement.travel_and_entertainment == "some updated travel_and_entertainment"
      assert income_statement.utilities == "some updated utilities"
    end

    test "update_income_statement/2 with invalid data returns error changeset" do
      income_statement = income_statement_fixture()
      assert {:error, %Ecto.Changeset{}} = Repairs.update_income_statement(income_statement, @invalid_attrs)
      assert income_statement == Repairs.get_income_statement!(income_statement.id)
    end

    test "delete_income_statement/1 deletes the income_statement" do
      income_statement = income_statement_fixture()
      assert {:ok, %IncomeStatement{}} = Repairs.delete_income_statement(income_statement)
      assert_raise Ecto.NoResultsError, fn -> Repairs.get_income_statement!(income_statement.id) end
    end

    test "change_income_statement/1 returns a income_statement changeset" do
      income_statement = income_statement_fixture()
      assert %Ecto.Changeset{} = Repairs.change_income_statement(income_statement)
    end
  end
end
