defmodule Demo.IncomeStatements do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.IncomeStatement
  alias Demo.Entities.Entity
  alias Demo.Groups.Group
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul
  alias Demo.Taxations.Taxation
  alias Demo.Families.Family

  def list_income_statements(id) do
    IncomeStatement
    |> entity_income_statements_query(id)
    |> Repo.all()
  end

  def get_income_statement!(id), do: Repo.get!(IncomeStatement, id)

  def get_entity_income_statement(entity_id) do
    IncomeStatement
    |> entity_income_statements_query(entity_id)
    |> Repo.one()
  end

  defp entity_income_statements_query(query, entity_id) do
    from(i in query, where: i.entity_id == ^entity_id)
  end

  # ? Default 
  def create_income_statement() do
    %IncomeStatement{}
    |> Repo.insert()
  end

  # ? Taxation 국세청 
  def create_income_statement(%Taxation{} = taxation, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, taxation)
    |> Repo.insert()
  end

  # ? 기업 
  def create_income_statement(%Entity{} = entity, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end
  
  # ? Group 
  def create_income_statement(%Group{} = group) do
    attrs = create_attrs(group)

    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  def create_income_statement(%Group{} = group, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  #? Family
  def create_income_statement(%Family{} = family) do
    attrs = create_attrs(family)

    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  def create_income_statement(%Family{} = family, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  #? Supul  
  def create_income_statement(%Supul{} = supul) do
    attrs = create_attrs(supul)

    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  def create_income_statement(%Supul{} = supul, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  #? State Supul
  def create_income_statement(%StateSupul{} = state_supul) do
    attrs = create_attrs(state_supul)

    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  def create_income_statement(%StateSupul{} = state_supul, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  #? Nation Supul
  def create_income_statement(%NationSupul{} = nation_supul) do
    attrs = create_attrs(nation_supul)

    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def create_income_statement(%NationSupul{} = nation_supul, attrs) do
    %IncomeStatement{}
    |> IncomeStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def update_income_statement(%IncomeStatement{} = income_statement, attrs) do
    income_statement
    |> IncomeStatement.changeset(attrs)
    |> Repo.update()
  end

  def change_income_statement(%IncomeStatement{} = income_statement) do
    IncomeStatement.changeset(income_statement, %{})
  end

  def add_expense(%IncomeStatement{} = income_statement, %{amount: amount}) do
    accrued_expense = Decimal.add(income_statement.expense, amount)
    update_income_statement(income_statement, %{expense: accrued_expense})
  end

  def add_revenue(%IncomeStatement{} = income_statement, %{amount: amount}) do   
    accrued_revenue = Decimal.add(income_statement.revenue, amount)
    update_income_statement(income_statement, %{revenue: accrued_revenue})
  end

  '''
    def delete_income_statement(%IncomeStatement{} = income_statement) do
      Repo.delete(income_statement)
    end
  '''

  defp create_attrs(group_or_supul) do
    list_IS =
      case group_or_supul do
        %Group{} ->
          entities = Repo.preload(group_or_supul, :entities).entities

          Enum.map(entities, fn entity ->
            Repo.preload(entity, :income_statement).income_statement
          end)

        %Supul{} ->
          entities = Repo.preload(group_or_supul, :entities).entities

          Enum.map(entities, fn entity ->
            Repo.preload(entity, :income_statement).income_statement
          end)

        %StateSupul{} ->
          supuls = Repo.preload(group_or_supul, :supuls).supuls

          Enum.map(supuls, fn supul -> Repo.preload(supul, :income_statement).income_statement end)

        %NationSupul{} ->
          state_supuls = Repo.preload(group_or_supul, :state_supuls).state_supuls

          Enum.map(state_supuls, fn state_supul ->
            Repo.preload(state_supul, :income_statement).income_statement
          end)

        _ ->
          "error"
      end

    compensation =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.compensation, acc)
      end)

    cost_of_goods_sold =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.cost_of_goods_sold, acc)
      end)

    depreciation_and_amortization =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.depreciation_and_amortization, acc)
      end)

    employee_benefits =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.employee_benefits, acc)
      end)

    expense =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.expense, acc) end)

    income_taxes =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.income_taxes, acc)
      end)

    insurance =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.insurance, acc)
      end)

    marketing =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.marketing, acc)
      end)

    office =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.office, acc) end)

    payroll =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.payroll, acc) end)

    professional_fees =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.professional_fees, acc)
      end)

    rent =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.rent, acc) end)

    repair_and_maintenance =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.repair_and_maintenance, acc)
      end)

    revenue =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.revenue, acc) end)

    sales_discounts =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.sales_discounts, acc)
      end)

    supplies =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.supplies, acc) end)

    taxes =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.taxes, acc) end)

    travel_and_entertainment =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.travel_and_entertainment, acc)
      end)

    utilities =
      Enum.reduce(list_IS, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.utilities, acc)
      end)

    attrs = %{
      compensation: compensation,
      cost_of_goods_sold: cost_of_goods_sold,
      depreciation_and_amortization: depreciation_and_amortization,
      employee_benefits: employee_benefits,
      income_taxes: income_taxes,
      insurance: insurance,
      marketing: marketing,
      office: office,
      payroll: payroll,
      professional_fees: professional_fees,
      rent: rent,
      repair_and_maintenance: repair_and_maintenance,
      revenue: revenue,
      sales_discounts: sales_discounts,
      supplies: supplies,
      taxes: taxes,
      travel_and_entertainment: travel_and_entertainment,
      utilities: utilities,
      expense: expense
    }
  end
end
