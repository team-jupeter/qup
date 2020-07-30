defmodule Demo.EquityStatements do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.EquityStatement
  alias Demo.Entities.Entity
  alias Demo.Groups.Group
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul
  alias Demo.Taxations.Taxation
  alias Demo.Families.Family

  def get_equity_statement!(id), do: Repo.get!(EquityStatement, id)

  def get_entity_equity_statement(id) do
    EquityStatement
    |> entity_equity_statements_query(id)
    |> Repo.one()
  end

  defp entity_equity_statements_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end

  # ? Default 
  def create_equity_statement() do
    %EquityStatement{}
    |> Repo.insert()
  end

  # ? Taxation 
  def create_equity_statement(%Taxation{} = taxation, attrs = %{}) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, taxation)
    |> Repo.insert()
  end

  # ? 기업 
  def create_equity_statement(%Entity{} = entity, attrs = %{}) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  # ? 그룹  
  def create_equity_statement(%Group{} = group) do
    attrs = create_attrs(group)

    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  def create_equity_statement(%Group{} = group, attrs) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  # ? 가족  
  def create_equity_statement(%Family{} = family) do
    attrs = create_attrs(family)

    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  def create_equity_statement(%Family{} = family, attrs) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:family, family)
    |> Repo.insert()
  end

  # ? Supul  
  def create_equity_statement(%Supul{} = supul) do
    attrs = create_attrs(supul)

    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  def create_equity_statement(%Supul{} = supul, attrs) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  # ? State
  def create_equity_statement(%StateSupul{} = state_supul) do
    attrs = create_attrs(state_supul)

    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  def create_equity_statement(%StateSupul{} = state_supul, attrs) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  # ? Nation
  def create_equity_statement(%NationSupul{} = nation_supul) do
    attrs = create_attrs(nation_supul)

    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def create_equity_statement(%NationSupul{} = nation_supul, attrs) do
    %EquityStatement{}
    |> EquityStatement.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def update_equity_statement(%EquityStatement{} = equity_statement, attrs) do
    equity_statement
    |> EquityStatement.changeset(attrs)
    |> Repo.update()
  end

  def delete_equity_statement(%EquityStatement{} = equity_statement) do
    Repo.delete(equity_statement)
  end

  def change_equity_statement(%EquityStatement{} = equity_statement) do
    EquityStatement.changeset(equity_statement, %{})
  end

  def create_attrs(group_or_supul) do
    list_ES =
      case group_or_supul do
        %Group{} ->
          entities = Repo.preload(group_or_supul, :entities).entities

          Enum.map(entities, fn entity ->
            Repo.preload(entity, :equity_statement).equity_statement
          end)

        %Supul{} ->
          entities = Repo.preload(group_or_supul, :entities).entities

          Enum.map(entities, fn entity ->
            Repo.preload(entity, :equity_statement).equity_statement
          end)

        %StateSupul{} ->
          supuls = Repo.preload(group_or_supul, :supuls).supuls

          Enum.map(supuls, fn supul -> Repo.preload(supul, :equity_statement).equity_statement end)

        %NationSupul{} ->
          state_supuls = Repo.preload(group_or_supul, :state_supuls).state_supuls

          Enum.map(state_supuls, fn state_supul ->
            Repo.preload(state_supul, :equity_statement).equity_statement
          end)

        _ ->
          "error"
      end

    opening_balance =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.opening_balance, acc)
      end)

    net_income =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.net_income, acc)
      end)

    other_income =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_income, acc)
      end)

    issue_of_new_capital =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.issue_of_new_capital, acc)
      end)

    net_loss =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.net_loss, acc) end)

    other_loss =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.other_loss, acc)
      end)

    dividends =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.dividends, acc)
      end)

    withdrawal_of_capital =
      Enum.reduce(list_ES, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.withdrawal_of_capital, acc)
      end)

    attrs = %{
      opening_balance: opening_balance,
      net_income: net_income,
      other_income: other_income,
      issue_of_new_capital: issue_of_new_capital,
      net_loss: net_loss,
      other_loss: other_loss,
      dividends: dividends,
      withdrawal_of_capital: withdrawal_of_capital
    }
  end
end
