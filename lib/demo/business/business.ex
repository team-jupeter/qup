defmodule Demo.Business do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Business.Entity
  alias Demo.Business.Product
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
    |> Entity.changeset(attrs)
    |> Repo.update()
  end

  def delete_entity(%Entity{} = entity) do
    Repo.delete(entity)
  end 

  def create_entity(%User{} = user, attrs \\ %{}) do
    %Entity{}
    |> Entity.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def change_entity(%Entity{} = entity) do
    Entity.changeset(entity, %{})
  end
end
