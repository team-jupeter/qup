defmodule Demo.Constitutions do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Votes.Constitution

  def list_constitutions do
    Repo.all(Constitution)
  end

  def get_constitution!(id), do: Repo.get!(Constitution, id)

  def create_constitution(attrs \\ %{}) do
    %Constitution{}
    |> Constitution.changeset(attrs)  
    |> Repo.insert()
  end

  def update_constitution(%Constitution{} = constitution, attrs) do
    constitution
    |> Constitution.changeset(attrs)
    |> Repo.update()
  end

  def delete_constitution(%Constitution{} = constitution) do
    Repo.delete(constitution)
  end

  def change_constitution(%Constitution{} = constitution) do
    Constitution.changeset(constitution, %{})
  end
end
