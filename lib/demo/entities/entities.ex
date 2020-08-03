defmodule Demo.Entities do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Entities.Entity
  alias Demo.Entities.Product
  alias Demo.Entities.GPCCode
  alias Demo.Entities.BizCategory
  alias Demo.Accounts.User
  alias Demo.Accounts
  alias Demo.AccountBooks
  alias Demo.Groups
  alias Demo.Groups.Group
  alias Demo.Families
  alias Demo.Families.Family
  alias Demo.Reports.UpdateFinacialStatements
  alias Demo.Reports.FinancialReport
  alias Demo.Reports.BalanceSheet
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.CFStatement
  alias Demo.Reports.EquityStatement
  alias Demo.AccountBooks.AccountBook

  def create_biz_category!(%{standard: standard, name: name, code: code}) do
    Repo.insert!(%BizCategory{standard: standard, name: name, code: code}, on_conflict: :nothing)
  end

  def list_alphabetical_biz_categories do
    BizCategory
    |> BizCategory.alphabetical()
    |> Repo.all()
  end

  def list_user_entities(%User{} = user) do
    IO.puts("hi")
    user = Repo.preload(user, :entities)
    user.entities
  end

  def get_user_entity!(%User{} = _user, id) do
    Entity
    # |> user_entities_query(user)
    |> Repo.get!(id)
  end

  def get_entity!(id), do: Repo.get!(Entity, id)
  def get_product!(id), do: Repo.get!(Product, id)

  def update_entity(%Entity{} = entity, attrs) do
    entity
    |> Entity.changeset_update_entity(attrs)
    |> Repo.update()
  end

  def minus_gab_balance(%Entity{} = entity, %{amount: amount}) do
    minus_gab_balance = Decimal.sub(entity.gab_balance, amount)
    update_entity(entity, %{gab_balance: minus_gab_balance})
  end

  def plus_gab_balance(%Entity{} = entity, %{amount: amount}) do
    plus_gab_balance = Decimal.add(entity.gab_balance, amount)
    update_entity(entity, %{gab_balance: plus_gab_balance})
  end

  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end

  def create_default_entity(user, attrs) do
    attrs = make_default_financial_statements(attrs)

    family = Repo.preload(user, :family).family
    supul = Repo.preload(user, :supul).supul
    supul_name = supul.name

    attrs = Map.merge(attrs, %{family: family, supul: supul, supul_name: supul_name})

    {:ok, entity} =
      %Entity{}
      |> Entity.create_default_entity(user, attrs)
      |> Repo.insert()
    

      IO.puts "entity.type"
    UpdateFinacialStatements.add_financial_statements(entity)

    {:ok, entity}
  end

  def create_private_entity(attrs) do
    attrs = make_financial_statements(attrs)
    supul = Repo.preload(attrs.user, :supul).supul
    attrs = Map.merge(attrs, %{supul: supul})

    attrs =
      case attrs.default_group do
        true ->
          {:ok, group} = Groups.create_group(%{type: "default group", name: attrs.user.name})
          attrs = Map.merge(attrs, %{group: group})

        false ->
          attrs = Map.merge(attrs, %{group: attrs.group})
      end

    %Entity{}
    |> Entity.create_private_entity(attrs)
    |> Repo.insert()
  end

  def create_private_entity(current_user, attrs) do
    attrs = make_financial_statements(attrs)
    supul = Repo.preload(current_user, :supul).supul
    attrs = Map.merge(attrs, %{supul: supul})

    attrs =
      case attrs.default_group do
        true ->
          {:ok, group} = Groups.create_group()
          attrs = Map.merge(attrs, %{group: group})

        false ->
          attrs = Map.merge(attrs, %{group: attrs.group})
      end

    %Entity{}
    |> Entity.create_private_entity(current_user, attrs)
    |> Repo.insert()
  end

  def create_public_entity(attrs) do
    attrs = make_financial_statements(attrs)

    %Entity{}
    |> Entity.create_public_entity(attrs)
    |> Repo.insert()
  end

  def create_public_entity(current_user, attrs) do
    attrs = make_financial_statements(attrs)

    %Entity{}
    |> Entity.create_public_entity(current_user, attrs)
    |> Repo.insert()
  end

  def create_product(%Entity{} = entity, attrs \\ %{}) do
    attrs = make_financial_statements(attrs)

    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  def create_GPCCode(attrs \\ %{}) do
    %GPCCode{}
    |> GPCCode.changeset(attrs)
    |> Repo.insert()
  end

  def change_entity(%Entity{} = entity) do
    Entity.changeset(entity, %{})
  end

  def new_entity(%Entity{} = entity) do
    Entity.new_changeset(entity, %{})
  end

  defp make_default_financial_statements(attrs) do
    ab = %AccountBook{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}

    attrs = Map.merge(attrs, %{ab: ab, bs: bs, cf: cf, es: es, fr: fr})
  end

  defp make_financial_statements(attrs) do
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}

    attrs = Map.merge(attrs, %{is: is, bs: bs, cf: cf, es: es, fr: fr})
  end
end
