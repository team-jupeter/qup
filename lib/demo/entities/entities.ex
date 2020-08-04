defmodule Demo.Entities do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Entities.Entity
  alias Demo.Products.Product
  alias Demo.Products.GPCCode
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
  alias Demo.GabAccounts.GabAccount

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

  def list_entity_products(%Entity{} = entity) do 
    Repo.preload(entity, :products).products
    # Product
    # |> entity_products_query(entity)
    # |> Repo.all()
  end

  def get_user_entity!(%User{} = _user, id) do
    Entity
    # |> user_entities_query(user)
    |> Repo.get!(id)
  end

  def get_entity!(id), do: Repo.get!(Entity, id)

  def get_entity_product!(%Entity{} = entity, id) do
    Product
    |> entity_products_query(entity)
    |> Repo.get!(id)
  end 

  defp entity_products_query(query, %Entity{id: entity_id}) do
    from(p in query, where: p.entity_id == ^entity_id)
  end

  def update_entity(%Entity{} = entity, attrs) do
    entity
    |> Entity.changeset_update_entity(attrs)
    |> Repo.update()
  end

  def minus_gab_balance(%Entity{} = entity, %{amount: amount}) do
    new_gab_balance = Decimal.sub(entity.gab_balance, amount)
    update_entity(entity, %{gab_balance: new_gab_balance})

    # case entity.type do
    #   "default" ->
    #     family = Repo.preload(entity, :family).family
    #     new_gab_balance = Decimal.sub(family.gab_balance, amount)
    #     Families.update_family(family, %{gab_balance: new_gab_balance})

    #   "private" ->
    #     group = Repo.preload(entity, :group).group
    #     new_gab_balance = Decimal.sub(group.gab_balance, amount)
    #     Groups.update_group(group, %{gab_balance: new_gab_balance})

    #   "public" ->
    #     true
    # end
  end

  def plus_gab_balance(%Entity{} = entity, %{amount: amount}) do
    new_gab_balance = Decimal.add(entity.gab_balance, amount)
    update_entity(entity, %{gab_balance: new_gab_balance})
  end

  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end


  def create_default_entity(user, attrs) do
    attrs = make_default_financial_statements(attrs)

    IO.puts("attrs.ga.id")

    family = Repo.preload(user, :family).family
    supul = Repo.preload(user, :supul).supul
    supul_name = supul.name

    attrs = Map.merge(attrs, %{family: family, supul: supul, supul_name: supul_name})

    {:ok, entity} =
      %Entity{}
      |> Entity.create_default_entity(user, attrs)
      |> Repo.insert()

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
    ga = %GabAccount{}

    attrs = Map.merge(attrs, %{ab: ab, bs: bs, cf: cf, es: es, fr: fr, ga: ga})
  end

  defp make_financial_statements(attrs) do
    is = %IncomeStatement{}
    bs = %BalanceSheet{}
    cf = %CFStatement{}
    fr = %FinancialReport{}
    es = %EquityStatement{}
    ga = %GabAccount{}

    attrs = Map.merge(attrs, %{is: is, bs: bs, cf: cf, es: es, fr: fr, ga: ga})
  end
end
