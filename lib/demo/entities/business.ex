defmodule Demo.Business do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Accounts.Entity
  alias Demo.Accounts.User

  def list_entities do
    Repo.all(Entity)
  end

  def list_user_entities(%User{} = user) do
    Entity
    |> user_entities_query(user)
    |> Repo.all()
  end

  def get_user_entity!(%User{} = user, id) do
    Entity
    |> user_entities_query(user)
    |> Repo.get!(id)
  end

  def get_entity!(id), do: Repo.get!(Entity, id)

  defp user_entities_query(query, %User{id: user_id}) do
    from(e in query, where: e.user_id == ^user_id)
  end

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
