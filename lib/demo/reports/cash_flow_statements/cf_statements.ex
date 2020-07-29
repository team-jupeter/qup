defmodule Demo.CFStatements do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.CFStatement
  alias Demo.Entities.Entity
  alias Demo.Groups.Group
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul
  alias Demo.Taxations.Taxation
  alias Demo.Families.Family

  def get_cf_statement!(id), do: Repo.get!(CFStatement, id)

  def get_entity_cf_statement!(entity_id) do
    CFStatement
    |> entity_cf_statements_query(entity_id)
    |> Repo.all()
  end

  defp entity_cf_statements_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end

  # ? Default 
  def create_cf_statement(attrs \\ %{}) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Repo.insert()
  end

  # ? Taxation 
  def create_cf_statement(%Taxation{} = taxation, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, taxation)
    |> Repo.insert()
  end

  # ? 기업 
  def create_cf_statement(%Entity{} = entity, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  # ? 그룹 
  def create_cf_statement(%Group{} = group) do
    attrs = create_attrs(group)

    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  def create_cf_statement(%Group{} = group, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  # ? 가족 
  def create_cf_statement(%Family{} = family) do
    attrs = create_attrs(family)

    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  def create_cf_statement(%Family{} = family, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  # ? Supul  
  def create_cf_statement(%Supul{} = supul) do
    attrs = create_attrs(supul)

    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  def create_cf_statement(%Supul{} = supul, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  # ? State
  def create_cf_statement(%StateSupul{} = state_supul) do
    attrs = create_attrs(state_supul)

    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  def create_cf_statement(%StateSupul{} = state_supul, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  # ? Nation
  def create_cf_statement(%NationSupul{} = nation_supul) do
    attrs = create_attrs(nation_supul)

    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def create_cf_statement(%NationSupul{} = nation_supul, attrs) do
    %CFStatement{}
    |> CFStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def update_cf_statement(%CFStatement{} = cf_statement, attrs) do
    cf_statement
    |> CFStatement.changeset(attrs)
    |> Repo.update()
  end

  def change_cf_statement(%CFStatement{} = cf_statement) do
    CFStatement.changeset(cf_statement, %{})
  end

  '''
    def delete_cf_statement(%CFStatement{} = cf_statement) do
      Repo.delete(cf_statement)
    end
  '''

  def create_attrs(group_or_supul) do
    list_CF =
      case group_or_supul do
        %Group{} ->
          entities = Repo.preload(group_or_supul, :entities).entities
          Enum.map(entities, fn entity -> Repo.preload(entity, :cf_statement).cf_statement end)

        %Supul{} ->
          entities = Repo.preload(group_or_supul, :entities).entities
          Enum.map(entities, fn entity -> Repo.preload(entity, :cf_statement).cf_statement end)

        %StateSupul{} ->
          supuls = Repo.preload(group_or_supul, :supuls).supuls
          Enum.map(supuls, fn supul -> Repo.preload(supul, :cf_statement).cf_statement end)

        %NationSupul{} ->
          state_supuls = Repo.preload(group_or_supul, :state_supuls).state_supuls

          Enum.map(state_supuls, fn state_supul ->
            Repo.preload(state_supul, :cf_statement).cf_statement
          end)

        _ ->
          "error"
      end

    capital_expenditures =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.capital_expenditures, acc)
      end)

    changes_in_working_capital =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.changes_in_working_capital, acc)
      end)

    debt_issuance =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.debt_issuance, acc)
      end)

    depreciation_amortization =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.depreciation_amortization, acc)
      end)

    equity_issuance =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.equity_issuance, acc)
      end)

    net_earnings =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.net_earnings, acc)
      end)

    opening_cash_balance =
      Enum.reduce(list_CF, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.opening_cash_balance, acc)
      end)

    attrs = %{
      capital_expenditures: capital_expenditures,
      changes_in_working_capital: changes_in_working_capital,
      debt_issuance: debt_issuance,
      depreciation_amortization: depreciation_amortization,
      equity_issuance: equity_issuance,
      net_earnings: net_earnings,
      opening_cash_balance: opening_cash_balance
    }
  end
end
