defmodule Demo.Business do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Business.Entity
  alias Demo.Business.Product
  alias Demo.Business.GPCCode
  alias Demo.Business.BizCategory
  alias Demo.Accounts.User


  def create_biz_category!(%{standard: standard, name: name, code: code}) do
    Repo.insert!(%BizCategory{standard: standard, name: name, code: code}, on_conflict: :nothing)
  end

  def list_alphabetical_biz_categories do
   BizCategory
    |> BizCategory.alphabetical()
    |> Repo.all()
  end

  
  def list_user_entities(%User{} = user) do
    IO.puts "hi"
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

  # def create_entity(current_user, attrs \\ %{}) do
  #   %Entity{current_user, attrs}
  #   |> Entity.create_entity(attrs)
  #   |> Repo.insert()
  # end

  def create_private_entity(attrs) do
    %Entity{}
    |> Entity.create_private_entity(attrs)
    |> Repo.insert()
  end

  def create_private_entity(current_user, attrs) do
    %Entity{}
    |> Entity.create_private_entity(current_user, attrs)
    |> Repo.insert()
  end
 
  def create_public_entity(attrs) do
    %Entity{}
    |> Entity.create_public_entity(attrs)
    |> Repo.insert()
  end

  def create_public_entity(current_user, attrs) do
    %Entity{}
    |> Entity.create_public_entity(current_user, attrs)
    |> Repo.insert()
  end
 
  def create_product(%Entity{} = entity, attrs \\ %{}) do
    IO.inspect entity

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
end
