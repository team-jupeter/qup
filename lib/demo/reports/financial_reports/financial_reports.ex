defmodule Demo.FinancialReports do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.FinancialReport
  alias Demo.Entities.Entity
  alias Demo.Groups.Group
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul
  alias Demo.Taxations.Taxation

  def get_financial_report!(id), do: Repo.get!(FinancialReport, id)

  def get_entity_financial_report!(entity_id) do
    FinancialReport
    |> entity_financial_reports_query(entity_id)
    |> Repo.all()
  end

  defp entity_financial_reports_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end

  # ? Taxation 
  def create_financial_report(%Taxation{} = taxation, attrs = %{}) do
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, taxation)
    |> Repo.insert()
  end

  # ? 기업 
  def create_financial_report(%Entity{} = entity, attrs = %{}) do
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  # ? 그룹  
  def create_financial_report(%Group{} = group) do
    group = Repo.preload(group, :entities)
    attrs = create_attrs(group)

    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:group, group)
    |> Repo.insert()
  end

  # ? Supul  
  def create_financial_report(%Supul{} = supul) do
    supul = Repo.preload(supul, :entities)
    attrs = create_attrs(supul)

    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:supul, supul)
    |> Repo.insert()
  end

  def create_financial_report(%StateSupul{} = state_supul) do
    attrs = create_attrs(state_supul)
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
    |> Repo.insert()
  end

  def create_financial_report(%NationSupul{} = nation_supul) do
    attrs = create_attrs(nation_supul)
    %FinancialReport{}
    |> FinancialReport.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
    |> Repo.insert()
  end

  def update_financial_report(%FinancialReport{} = financial_report, attrs) do
    financial_report
    |> FinancialReport.changeset(attrs)
    |> Repo.update()
  end

  def change_financial_report(attrs) do
    FinancialReport.changeset(attrs)
  end

  '''
    def delete_financial_report(%FinancialReport{} = financial_report) do
      Repo.delete(financial_report)
    end
  '''

  defp create_attrs(group_or_supul) do
  entities = Repo.preload(group_or_supul, :entities).entities

    list_FR =
      Enum.map(entities, fn entity -> Repo.preload(entity, :financial_report).financial_report end)

    num_of_shares =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.num_of_shares, acc)
      end)

    num_of_shares_issued =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.num_of_shares_issued, acc)
      end)

    num_of_treasury_stocks =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.num_of_treasury_stocks, acc)
      end)

    market_capitalization =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.market_capitalization, acc)
      end)

    stock_price =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.stock_price, acc)
      end)

    intrinsic_value =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.intrinsic_value, acc)
      end)

    re_fmv =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.re_fmv, acc) end)

    debt_int_rate =
      Enum.reduce(list_FR, Decimal.from_float(0.00), fn x, acc ->
        Decimal.add(x.debt_int_rate, acc)
      end)

    attrs = %{
      num_of_shares: num_of_shares,
      num_of_shares_issued: num_of_shares_issued,
      num_of_treasury_stocks: num_of_treasury_stocks,
      market_capitalization: market_capitalization,
      stock_price: stock_price,
      intrinsic_value: intrinsic_value,
      re_fmv: re_fmv,
      debt_int_rate: debt_int_rate
    }
  end
end
